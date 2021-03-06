
create keyspace btree with replication = {'class':'SimpleStrategy', 'replication_factor':1};

create table store (
    name text PRIMARY KEY, 
    root_id timeUUID,
    slot_count int,
    count bigint,
    unique boolean,
    kvt int,
    ki text,
    vi text,
    ckas boolean,
    cvas boolean,
    vrsn int,
    is_del boolean);

create table node (
    id timeUUID PRIMARY KEY,
    vrsn int,      // current value version
    l_id timeUUID PRIMARY KEY,

    // set of items: key, version no., value
    s frozen <set<tuple<text, int, blob>>>,
    s_tt frozen <set<tuple<text, int, text>>>,
    s_bb frozen <set<tuple<blob, int, blob>>>,
    s_bt frozen <set<tuple<blob, int, text>>>,
    s_tid frozen <set<tuple<text, int, timeUUID>>>,
    s_bid frozen <set<tuple<blob, int, timeUUID>>>,

    // children logical IDs
    c_id frozen <set<timeUUID>>,
    is_del boolean,
);

// node datablocks can be used for storing very large BLOBs (vlblobs).
// SOP's datablock technology solves managing vlblobs without "streaming" req't.
create table node_blocks (
    id timeUUID PRIMARY KEY,
    vrsn int,      // current value version

    // if set, contains all other "block physical IDs" (timeUUID) (a.k.a. map) storing the rest of vlblob data.
    // otherwise, data fit into a single blob (stored in s_block).
    s_b_map frozen <set<timeUUID>>,
    s_block blob,

    // children logical IDs
    c_id frozen <set<timeUUID>>,
    is_del boolean,
);

// Logical to Physical ID table will allow seamless transaction commit processing.
// Only when the record here got updated that succeeding SOP Btree IO will reflect newly commited Node data changes.
create table virtual_id(
    l_id timeUUID PRIMARY KEY,
    is_idb boolean,
    p_ida timeUUID,
    p_idb timeUUID,
    is_del boolean
);

create table slot_value(
    id timeUUID Primary Key,
    v blob,
    is_del boolean,
);
create table slot_value_blocks(
    id timeUUID Primary Key,
    v_b_map frozen <set<timeUUID>>,
    v_block blob,
    is_del boolean,
);

create table recycle_bin (
    y int,
    m int,
    d int,
    h int,
    t int,          //(option) default to node type
    id timeUUID,
    lock_dt date,
    is_del boolean,
    Primary Key((t, is_del, y, m, d, h))
);

create table transaction_sandbox(
    tid timeUUID,   // Transaction ID (tid)
    store text,
    seq timeUUID,
    // read lock on kvp, add, update, delete
    act int,
    vrsn int,      // current value version, should be same if act=update,delete
    c_kt text,     // current Key
    c_kb blob,
    n_vt text,      // new Value
    n_vb blob,
    is_del boolean,
    Primary Key(tid, store, seq)
);
