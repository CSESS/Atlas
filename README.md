# nixos @ atlas

## Clone NixOS configuration
This clones the repo into directory `nixfiles` checked out on branch `nixos-atlas`; then changes directory into it and switches to a new branch `nixos-atlas-lock`; then calls `nixos-rebuild` to create the initial lock file.
```sh
git clone --branch nixos-atlas git@github.com:CSESS/atlas.git nixfiles
cd nixfiles && git switch -c nixos-atlas-lock
nixos-rebuild switch --flake . --update-input nixpkgs --commit-lock-file
```

### Private everything in directory
```sh
chmod -R g-rwx,o-rwx
```

### Configure identity for auto update
This lets the services commit lock file during auto updates.
```sh
git config user.email "$(id -un)@$(hostname)"
git config user.name "$(id -un)"
```

## Rebase onto upstream
This fetches `origin/nixos-atlas` onto the local `nixos-atlas`, then rebases `nixos-atlas-lock` onto `nixos-atlas`.
```sh
git fetch origin nixos-atlas:nixos-atlas
git rebase nixos-atlas
```

## Mirrors
- `git@github.com:CSESS/atlas.git`
