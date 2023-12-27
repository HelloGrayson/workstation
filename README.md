# dotfiles 

Automatically setup @HelloGrayson's Fedora Silverblue machine.

## How to run
```
$ export GITHUB_USERNAME=HelloGrayson
$ sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```
## References

Using Ansible to drive system state via Chezmoi:

- https://youtu.be/-RkANM9FfTM
- https://github.com/logandonley/dotfiles
