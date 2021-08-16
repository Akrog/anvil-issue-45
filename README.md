# Reproducer for anvil-runtime issue #45

This repo uses non-root podman instead of docker.

Steps to reproduce [anvil-runtime issue#45](https://github.com/anvil-works/anvil-runtime/issues/45):

```
$ ./build-base.sh  # Build's the base anvil-runtime container with tag anvil:6.0
$ ./build.sh  # Buildn't the app container with tag anvil-issue-45:master
$ ./run.sh  # Runs the app containter exporting port 3030 and mounting data on ./anvil-data
```

Once we see the message indicating that the service has finished the DB creation and is running:
```
Anvil websocket open
[INFO  anvil.executors.downlink] Downlink client connected with spec {:runtime "python3-full", :session_id "KnpdSpOhoTRsh6UY8jnv"}
Downlink authenticated OK
```

We hit `Ctrl + C` to stop it and then run `./run.sh` again.

This will result in a migration required error similar to this one:

```
Found 2 migration(s) for (base runtime) DB.
Executing Anvil migrations...
Database currently at "2021-06-19-runtime-sessions"
0 migration(s) to perform.
Database now at "2021-06-19-runtime-sessions"
Migration complete.
[TRACE anvil.app-server.run] Invalidating; new version 1
[INFO  anvil.app-server.tables] Data tables schema out of date. Here is the migration that will run if you restart Anvil with the --auto-migrate command-line flag:
[INFO  anvil.app-server.tables] ({:type :UPDATE_TABLE, :table "providers", :title "Providers"}
 {:type :DELETE_COLUMN, :table "providers", :column_name "email"}
 {:type :DELETE_COLUMN, :table "providers", :column_name "enabled"}
 {:type :ADD_COLUMN,
  :table "providers",
  :column
  {:name "users",
   :admin_ui {:width 200},
   :type "link_single",
   :target "users"}}
 {:type :ADD_COLUMN,
  :table "providers",
  :column
  {:name "display_name", :admin_ui {:width 200}, :type "string"}}
 {:type :ADD_COLUMN,
  :table "providers",
  :column {:name "config", :admin_ui {:width 200}, :type "string"}}
 {:type :ADD_COLUMN,
  :table "providers",
  :column {:name "created", :admin_ui {:width 200}, :type "datetime"}})

[INFO  anvil.app-server.tables] Anvil will now exit. Run with --ignore-invalid-schema to startup anyway, or --auto-migrate to apply the changes above.
Found Anvil App Server JAR in package directory
```
