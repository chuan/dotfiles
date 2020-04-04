# Configuration
Dev environment configuration files install/backup/restore

## Functional requirements
- Simple install/backup/restore.
- Support the following development environments.
  - macOS
  - Ubuntu/Pop!_OS
  - Arch Linux
- Rely on OS package manager whenever possible. Exceptions:
  - `antigen`:
    - https://bugs.launchpad.net/ubuntu/+source/zsh-antigen/+bug/1770915
    - https://github.com/zsh-users/antigen/issues/659
  - `fzf`: inconsistent installation locations and the need to include the location in `.vimrc` and `.zshrc`
- Separate work related settings.
- Separate installation scripts for GUI apps and programming langauges.

## GUI Applications
The following GUI applications are installed.

- alacritty
- emacs

## Programming languages

- Go
- Rust
