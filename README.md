# dotfiles 

Automatically setup @HelloGrayson's Fedora Silverblue machine.

## How to run

No need to check this repo out, just open the terminal and run:

```console
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply HelloGrayson
```
## References

Using Ansible to drive system state via Chezmoi:

- https://youtu.be/-RkANM9FfTM
- https://github.com/logandonley/dotfiles

Using distrobox/toolbx with custom images:
- https://youtu.be/7-FPAWjROos
- https://github.com/ublue-os/boxkit

Using Ansible to provision SilverBlue host.
- https://github.com/j1mc/ansible-silverblue
