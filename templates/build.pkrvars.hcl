/*
    DESCRIPTION: 
    Build account variables used for all builds.
    - Variables are passed to and used by guest operationg system configuration files (e.g., ks.cfg, autounattend.xml).
    - Variables are passed to and used by configuration scripts.
*/

// Default Account Credentials
build_username           = "kalen"
build_password           = "VMware123!"
build_password_encrypted = "$6$QdqN5bNmfP8hNK$S0D.J2i3NUyTGL08Nlq.RLysL9D7vLL11CA2cwWBvyefc2VuodIkiPlLA.1RNqHt4ruRRO98TJFVlweZG35ts1"
build_key                = "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAHs7Wu9YU8ZlMEIXVEfuC2j7xg3npglFwM90c3alD9AUNYlq62YTSEDefYRLOMZrLupTuny+DPFM4f3+GFVUIeIYwApTV9iw2zDUYvCelu1/AV9OqrJfs0qMUY41BTCq5e60NclK1fw4dt6aLwexAo8bT0yQS/lJiklJmG6DIJwzi07vg=="
hcp_bucket_description   = "Base Ubuntu 20.04 Cloud-Init Templates"
hcp_bucket_name          = "Ubuntu-20xx"