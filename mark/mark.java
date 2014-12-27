// Represents a node, linked to two other nodes
class Node {
  //protected means only this class and anything that extends from it (Sentinel) are able to access it
  protected String data;
  protected Node next;
  protected Node prev;
  
  //constructor
  public Node(String data) {
    this.data = data;
    this.next = this;
    this.prev = this;
  }

  //stick this node in between nodes n and p
  public void addInBetween(Node n, Node p){
    this.next = n;
    this.prev = p;
    n.prev = this;
    p.next = this;
  }

  /*
    this basically substitutes calling this.node.data or whatever outside of the node class itself
    instead you'd call this.node.getData() when something has a node whose data you want to access
    it's safer that way, since you don't have direct access to the node's properties
  */
  public String getData() {
    return this.data;
  }

  /*
    you never really have to do this.next outside of Node and Sentinel, which extends from Node
    so there's no point to return this.next, you just need to return the node's next's data
    same for prev
  */
  public String getNext() {
    return this.next.getData();
  }

  public String getPrev() {
    return this.prev.getData();
  }
}

// Represents a sentinel, which marks either the head or tail of a deque
class Sentinel extends Node {
  
  public Sentinel() {
    super("");
  }
  
  public void addAtHead(Node node) {
    node.addInBetween(this.next, this.prev);
    this.prev = this.prev;
    this.next = node;
  }
}


// Represents a deque, the wrapper for a sentinel
class Deque {
  private Sentinel sentinel;

  public Deque() {
    this.sentinel = new Sentinel();
  }

  public void addAtHead(String string) {
    Node newHead = new Node(string);
    /*
      you don't want to couple code too much, meaning you don't want to be calling this.sentinel.prev and this.sentinel.next
      so we just call a method of sentinel's that does stuff to its prev and next
    */
    this.sentinel.addAtHead(newHead);
  }

  public String getFirst() {
    return this.sentinel.getNext();
  }

  public String getLast() {
    return this.sentinel.getPrev();
  }
}


// Tests for deques and objects contained in deques
class ExamplesDeque {
  public static void main(String[] args) {
    Deque mtDeque = new Deque ();

    mtDeque.addAtHead("abc");

    System.out.println(mtDeque.getFirst()); //should be abc
    System.out.println(mtDeque.getLast()); //should be abc

    mtDeque.addAtHead("bcd");

    System.out.println(mtDeque.getFirst()); //should be bcd
    System.out.println(mtDeque.getLast()); //should be abc

    mtDeque.addAtHead("cde");

    System.out.println(mtDeque.getFirst()); //should be cde
    System.out.println(mtDeque.getLast()); //should be abc
  } 
}