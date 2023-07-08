# nixos @ atlas

## Clone NixOS configuration
This clones the repo into directory `nixfiles` to `/etc/nixos`; then calls `nixos-rebuild` to switch into the configuration.
```sh
git clone git@github.com:CSESS/Atlas.git /etc/nixos
nixos-rebuild switch --update-input nixpkgs --commit-lock-file
```

## Create a bootstrap image for Azure
This will build a VHD from the current `atlas` configuration.
```sh
nix build github:CSESS/Atlas#nixosConfigurations.atlas.config.system.build.azureImage
```

### Create the virtual machine from scratch in Azure
1. Create a storage account, create a container in the storage account, upload the VHD as page blob.
2. Create an Azure compute gallery.
3. Create a VM image version. Choose VHD, not managed image. Choose specialized.
4. Create the virtual machine, select the image form "Shared Images". Relax the inbound/outbound rules in Networking.

## Configure git identity for auto update
Auto-commit lockfile during auto updates.
```sh
# in /etc/nixos
git config user.email "$(id -un)@$(hostname)"
git config user.name "$(id -un)"
```

## Rebase onto upstream
This fetches `origin/nixos-atlas`, then fast-forward/rebase/reset local `nixos-atlas` according to origin.
```sh
git fetch origin nixos-atlas
git merge --ff-only FETCH_HEAD
git rebase FETCH_HEAD
git reset --hard FETCH_HEAD
```
