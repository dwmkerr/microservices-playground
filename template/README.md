# Template

This `README` provides a template for new clusters. Follow the guidelines below to make sure that each cluster is set up in a reasonably consistent way.

## Preparation

The project should include a `makefile` at the root. It should also include a `README` with setup instructions.

Running `make` should check the setup of the local machine, to see whether the appropriate software is installed and the appropriate settings are available. In general, confidential settings (such as keys) should be in environment variables. `make` should check these are set appropriately, and if they are not, direct the user to the `README`.

## Creation

The `make create` command should create all resources, finishing by showing the user enough information for them to understand the next steps (such as a login URL or a note on how their `kubectl` config is updated).

## Destruction

The `make destroy` command should destroy all resources, finishing by indicating to the user if the operation was successful.

