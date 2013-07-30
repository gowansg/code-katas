using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SplayTree
{
    public class SplayTree<T> where T : IComparable<T>
    {
        private Node<T> _root;

        public SplayTree()
        {
        }

        public SplayTree(T[] range)
        {
            _root = new Node<T>();
            BuildTreeFromRange(_root, range);
        }

        private void BuildTreeFromRange(Node<T> newNode, T[] range)
        {
            //todo: sort the list first
            if (range.Length == 0) return;

            var middle = range.Length / 2;
            newNode.Value = range[middle];

            newNode.Right = new Node<T>();
            var rightSubtree = range.Skip(middle)
                                    .Take(range.Length - middle - 1)
                                    .ToArray();
            BuildTreeFromRange(newNode.Right, rightSubtree);

            newNode.Left = new Node<T>();
            var leftSubtree = range.Take(middle - 1).ToArray();
            BuildTreeFromRange(newNode.Left, leftSubtree);
        }

        public Node<T> Search(T value)
        {
            return Search(_root, value);
        }

        private Node<T> Search(Node<T> currentNode, T value)
        {
            if (currentNode == null) return null;
            if (value.CompareTo(currentNode.Value) == 0) return currentNode;
            if (value.CompareTo(currentNode.Value) < 0) return Search(currentNode.Left, value);
            if (value.CompareTo(currentNode.Value) > 0) return Search(currentNode.Right, value);

            return null;
        }
    }

    public class Node<T>
    {
        public T Value { get; set; }
        public Node<T> Left { get; set; }
        public Node<T> Right { get; set; }
    }
}
