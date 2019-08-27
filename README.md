# Configuration
Dev environment configuration files install/backup/restore

## Functional requirements
- Simple install/backup/restore.
- Support the following development environments.
  - macOS
  - Pop!_OS
- Rely on OS package manager whenever possible. Exceptions:
  - `antigen`:
    - https://bugs.launchpad.net/ubuntu/+source/zsh-antigen/+bug/1770915
    - https://github.com/zsh-users/antigen/issues/659
  - `fzf`: inconsistent installation locations and the need to include the location in `.vimrc` and `.zshrc`
- Separate work related settings.
- Ask before installing any GUI applications.

## GUI Applications
The following GUI applications are installed.

### Mac 

```bash
brew cask ls --versions alacritty || brew cask install alacritty
brew cask ls --versions emacs || brew cask install emacs
```

### Ubuntu

- alacritty
- emacs
