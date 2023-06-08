# nixos @ atlas

## Clone NixOS configuration
This clones the repo into directory `nixfiles` checked out on branch `nixos-atlas`; then changes directory into it and switches to a new branch `nixos-atlas-lock`; then calls `nixos-rebuild` to create the initial lock file.
```sh
git clone --branch nixos-atlas git@github.com:CSESS/Atlas.git nixfiles
cd nixfiles && git switch -c nixos-atlas-lock
nixos-rebuild switch --flake . --update-input nixpkgs --commit-lock-file
```

## Create a bootstrap image for Azure
This will build a VHD from the current configuration.
```sh
nix build github:CSESS/Atlas#nixosConfigurations.atlas.config.system.build.azureImage
```
### Create the virtual machine from scratch in Azure
- Create a storage account, create a container in the storage account, upload the VHD as page blob there.
- Then, create an Azure compute gallery, enable (default) RBAC sharing.
- Then, create a VM image version. Make sure to select Gen 2, arm64 options.
- Then, create the virtual machine, select the image form "Shared Images".
- Might want to relax the inbound/outbound rules in Networking.

## Configure git identity for auto update
This lets the services commit lock file during auto updates.
```sh
# make sure we are in /etc/nixos
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
- `git@github.com:CSESS/Atlas.git`
