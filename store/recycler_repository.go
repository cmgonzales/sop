package store

import "sop/btree"

type rc Connection

func (conn *rc) Get(batch int, objectType int) []*btree.Recyclable{
	return nil
}
func (conn *rc) Add(recyclables []*btree.Recyclable) error{
	return nil
}
func (conn *rc) Remove(items []*btree.Recyclable) error{
	return nil
}
