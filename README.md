# dotfiles 

Automatically setup @HelloGrayson's Fedora Silverblue machine by running:

```console
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply HelloGrayson
```

To setup these files for development, run:

```
$ curl -fsLS get.chezmoi.io
$ chezmoi init git@github.com:HelloGrayson/dotfiles.git
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
