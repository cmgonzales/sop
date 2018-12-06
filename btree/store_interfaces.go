package btree

//import "../transaction"

// Btree interface defines publicly callable methods of Btree.
type BtreeInterface interface{
	Add(key interface{}, value interface{}) (bool, error)
}

// backend store persistence interfaces

type StoreRepository interface{
	Get(name string) *Store
	Add(*Store) error
	Remove(name string) error
}

type NodeRepository interface{
	Get(nodeID UUID) (*Node, error)
	Add(*Node) error
	Update(*Node) error
	Remove(nodeID UUID) error
}

type VirtualIDRepository interface{
	Get(logicalID UUID) *VirtualID
	Add(*VirtualID) error
	Update(*VirtualID) error
	Remove(logicalID UUID) error
}

type Recycler interface{
	Get(batch int, objectType int) []*Recyclable
	Add([]*Recyclable) error
	//Update([]*Recyclable) error
	Remove([]*Recyclable) error
}

type TransactionRepository interface{
	Get(transactionID UUID) ([]*TransactionEntry, error)
	GetByStore(transactionID UUID, storeName string) ([]*TransactionEntry, error)
	Add([]*TransactionEntry) error
	//Update([]*TransactionEntry) error
	MarkDone([]*TransactionEntryKeys) error
}