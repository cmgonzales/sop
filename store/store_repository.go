package store;

import "sop/btree"

type sc Connection

func (conn *sc) Get(name string) *btree.Store{
	return nil;
}

func  (conn *sc) Add(source *btree.Store) error{
	return nil;
}

func  (conn *sc) Remove(name string) error{
	return nil;
}
