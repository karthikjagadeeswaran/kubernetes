
# 2 sync replica and 1 async replica config
    patronictl -c .config/patroni/patronictl.yaml edit-config

    // change the config
    loop_wait: 10
    maximum_lag_on_failover: 33554432
    nosync: true // newly added
    postgresql:
    parameters:
        archive_mode: 'on'
        archive_timeout: 1800s
        autovacuum_analyze_scale_factor: 0.02
        autovacuum_max_workers: 5
        autovacuum_vacuum_scale_factor: 0.05
        checkpoint_completion_target: 0.9
        hot_standby: 'on'
        log_autovacuum_min_duration: 0
        log_checkpoints: 'on'
        log_connections: 'on'
        log_disconnections: 'on'
        log_line_prefix: '%t [%p]: [%l-1] %c %x %d %u %a %h '
        log_lock_waits: 'on'
        log_min_duration_statement: 500
        log_statement: ddl
        log_temp_files: 0
        max_connections: 1000
        max_replication_slots: 10
        max_wal_senders: 10
        synchronous_commit: remote_write // newly added
        synchronous_standby_names: ANY 2 (patroni-test-replica-0,patroni-test-replica-1,patroni-test-replica-2) // newly added but it doesn't work
        tcp_keepalives_idle: 900
        tcp_keepalives_interval: 100
        track_functions: all
        wal_level: hot_standby
        wal_log_hints: 'on'
    use_pg_rewind: true
    use_slots: true
    retry_timeout: 10
    synchronous_mode: true // newly added
    synchronous_node_count: 2 // newly added
    ttl: 30