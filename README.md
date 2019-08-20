# Configuration
Dev envrionment configuration files install/backup/restore

## Funtional requirements
- Simple install/backup/restore.
- Support the following development environments.
    - macOS
    - Pop!_OS
- Rely on OS package manager whenever possible.
- Separate work related settings.
- Do not install any gui applications.

## GUI Applications

### Mac 

```bash
brew ls --versions vim || brew install brew
brew cask ls --versions alacritty || brew cask install alacritty
brew cask ls --versions emacs || brew cask install emacs
```

### Ubuntu

- alacritty
- emacs
