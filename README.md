# AGiXT ISO Creation Script

This Bash script automates the creation of a custom ISO for AGiXT using VirtualBox. The script sets up a virtual machine, installs the specified operating system (Ubuntu), and installs the desired program (Apache2) before exporting the virtual machine's disk as an ISO file.

## Prerequisites

- VirtualBox must be installed on the system running the script.
- The script assumes that the Ubuntu ISO file is available at the specified URL (`ISO_URL`).

## Usage

1. Set the desired variables at the beginning of the script:
   - `VM_NAME`: The name of the virtual machine.
   - `VM_OS`: The operating system type (e.g., "Ubuntu_64").
   - `VM_RAM`: The amount of RAM allocated to the virtual machine (in MB).
   - `VM_DISK_SIZE`: The size of the virtual machine's disk (in MB).
   - `ISO_URL`: The URL of the Ubuntu ISO file.
   - `EXPORT_FORMAT`: The format of the exported disk (e.g., "ISO").
   - `PROGRAM_TO_INSTALL`: The program to be installed in the virtual machine (e.g., "apache2").

2. Run the script:
   ```
   ./agixt_iso_creation.sh
   ```

## Script Functionality

1. The script creates a new virtual machine with the specified name and operating system type using VirtualBox.

2. It sets the virtual machine's settings, including memory, video memory, and creates a virtual disk of the specified size.

3. The script downloads the Ubuntu ISO file from the specified URL and attaches it to the virtual machine's IDE controller.

4. It enables unattended installation of the operating system using the provided username, password, and other settings.

5. The virtual machine is started in headless mode (without a graphical interface).

6. After waiting for the virtual machine to boot, the script updates the package manager and installs the specified program (Apache2) using the `VBoxManage guestcontrol` command.

7. The virtual machine is then gracefully shutdown using the ACPI power button signal.

8. Once the virtual machine is powered off, the script exports the virtual disk to the specified format (ISO) using the `VBoxManage clonehd` and `VBoxManage convertfromraw` commands.

9. Finally, the script displays a completion message indicating that the virtual machine creation, program installation, and ISO export have been completed.

## Customization

- To customize the virtual machine settings or the installed program, modify the corresponding variables at the beginning of the script.
- If a different operating system or installation method is desired, the script may need to be adapted accordingly.

## Note

- The script assumes that the necessary permissions and access rights are available to create and manage virtual machines using VirtualBox.
- The script may take a significant amount of time to complete, depending on the size of the ISO file, the virtual machine settings, and the installation process.

By using this script, you can automate the creation of a custom ISO for AGiXT, which can be used for further experimentation and development in the field of artificial general intelligence.
