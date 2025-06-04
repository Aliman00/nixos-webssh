# Use a Nix-enabled base image
FROM nixos/nix:latest

# Add the nixos-25.05 channel, update it,
# and then install webssh from that specific channel.
RUN nix-channel --add https://nixos.org/channels/nixos-25.05 nixos-25.05 && \
    nix-channel --update && \
    nix-env -f channel:nixos-25.05 -iA webssh

# Expose the port wssh will listen on.
EXPOSE 8000

# Set the default command to run wssh.
# It needs to bind to 0.0.0.0 to be accessible from outside the container.
# The path /root/.nix-profile/bin/ is where nix-env installs binaries.
CMD ["/root/.nix-profile/bin/wssh", "--address=0.0.0.0", "--port=8000"]
