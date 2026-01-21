#!/usr/bin/env python3
"""
Automated server setup script
Connects to the server and runs the installation script
"""

import subprocess
import sys
import time

SERVER_IP = "116.203.251.113"
SERVER_USER = "root"
SERVER_PASSWORD = "stxJTsTbV4bfRtKxXaaN"
SETUP_URL = "https://raw.githubusercontent.com/eduardkolberg/testclaude/claude/hello-world-github-actions-3RoPr/quick-setup.sh"

def run_ssh_command(command):
    """Run a command on the remote server using sshpass"""
    ssh_cmd = [
        "sshpass", "-p", SERVER_PASSWORD,
        "ssh",
        "-o", "StrictHostKeyChecking=no",
        "-o", "UserKnownHostsFile=/dev/null",
        f"{SERVER_USER}@{SERVER_IP}",
        command
    ]

    try:
        result = subprocess.run(
            ssh_cmd,
            capture_output=True,
            text=True,
            timeout=300  # 5 minutes timeout
        )
        return result.returncode, result.stdout, result.stderr
    except subprocess.TimeoutExpired:
        return 1, "", "Command timed out"
    except Exception as e:
        return 1, "", str(e)

def main():
    print("=" * 70)
    print("  Hello World App - Automated Server Setup")
    print("=" * 70)
    print()

    # Check if sshpass is installed
    try:
        subprocess.run(["which", "sshpass"], check=True, capture_output=True)
    except subprocess.CalledProcessError:
        print("❌ Error: sshpass is not installed")
        print()
        print("Install it with:")
        print("  Ubuntu/Debian: sudo apt-get install sshpass")
        print("  macOS: brew install hudochenkov/sshpass/sshpass")
        sys.exit(1)

    print("📡 Testing connection to server...")
    returncode, stdout, stderr = run_ssh_command("echo 'Connection successful'")

    if returncode != 0:
        print(f"❌ Failed to connect to server: {stderr}")
        sys.exit(1)

    print("✅ Connection successful!")
    print()

    print("🚀 Starting server setup...")
    print("This will take 3-5 minutes...")
    print()

    # Run the setup script
    setup_command = f"curl -fsSL {SETUP_URL} | bash"
    returncode, stdout, stderr = run_ssh_command(setup_command)

    if returncode != 0:
        print(f"❌ Setup failed: {stderr}")
        sys.exit(1)

    print(stdout)
    print()
    print("=" * 70)
    print("✅ Server setup complete!")
    print("=" * 70)
    print()
    print(f"🌐 Your application is now running at: http://{SERVER_IP}")
    print()
    print("Next steps:")
    print("1. Add GitHub Secrets (see SETUP_GUIDE_RU.md)")
    print("2. Push code to trigger automatic deployment")
    print()

if __name__ == "__main__":
    main()
