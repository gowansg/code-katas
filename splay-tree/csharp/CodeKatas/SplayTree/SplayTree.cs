using System;
using System.Collections.Generic;
using System.Linq;

namespace SplayTree
{
    public class SplayTree<T> where T : IComparable<T>
    {
        private Node<T> _root;

        public SplayTree()
        {
        }

        public SplayTree(T[] values)
        {
            _root = BuildTreeFromValues(values, null);
        }

        private Node<T> BuildTreeFromValues(T[] values, Node<T> parent)
        {
            //todo: sort the list first
            if (values.Length == 0) return null;

            var middle = values.Length/2;
            var newNode = new Node<T>(values[middle]);

            var rightSubtree = values.Skip(middle + 1)
                                     .Take(values.Length - middle + 1)
                                     .ToArray();
            newNode.Right = BuildTreeFromValues(rightSubtree, newNode);

            var leftSubtree = values.Take(middle).ToArray();
            newNode.Left = BuildTreeFromValues(leftSubtree, newNode);

            return newNode;
        }

        private Node<T> Search(T value)
        {
            var current = _root;
            while (current != null)
            {
                var comparsionResult = value.CompareTo(current.Value);
                if (comparsionResult == 0) return current;

                current = comparsionResult < 0 ? current.Left : current.Right;
            }

            return null;
        }

        public Node<T> Find(T value)
        {
            return Find(_root, value);
        }

        private Node<T> Find(Node<T> node, T value)
        {
            var comparisonResult = value.CompareTo(node.Value);

            if (comparisonResult == 0) return node;

            var pivot = comparisonResult < 0 
                ? Find(node.Left, value) 
                : Find(node.Right, value);

            return Rotate(node, pivot);
        }

        private Node<T> Rotate(Node<T> parent, Node<T> pivot)
        {
            if (parent == _root) _root = pivot;

            if (parent.Right == pivot) // then rotate left
            {
                parent.Right = pivot.Left;
                pivot.Left = parent;
            }
            else
            {
                parent.Left = pivot.Right;
                pivot.Right = parent;
            }

            return pivot;
        }

        public IEnumerable<Node<T>> Traverse(TreeTraversal traversal)
        {
            switch (traversal)
            {
                case TreeTraversal.InOrder:
                    return InOrderTraversal(_root);
                case TreeTraversal.PreOrder:
                    return PreOrderTraversal(_root);
                case TreeTraversal.PostOrder:
                    return PostOrderTraversal(_root);
                default:
                    throw new Exception(String.Format("'{0}' is not a recognized traversal method.", traversal));
            }
        }

        public override string ToString()
        {
            return ToString(TreeTraversal.InOrder);
        }

        public string ToString(TreeTraversal traversalMethod)
        {
            return String.Join(",", Traverse(traversalMethod).Select(n => n.Value));
        }

        private IEnumerable<Node<T>> InOrderTraversal(Node<T> current)
        {
            if (current.Left != null)
                foreach (var node in InOrderTraversal(current.Left)) yield return node;

            yield return current;

            if (current.Right != null) 
                foreach (var node in InOrderTraversal(current.Right)) yield return node;
        }

        private IEnumerable<Node<T>>PreOrderTraversal(Node<T> current)
        {
            yield return current;
            
            if (current.Left != null)
                foreach (var node in PreOrderTraversal(current.Left)) yield return node;
            if (current.Right != null)
                foreach (var node in PreOrderTraversal(current.Right)) yield return node;
        }

        private IEnumerable<Node<T>> PostOrderTraversal(Node<T> current)
        {
            if (current.Left != null)
                foreach (var node in PostOrderTraversal(current.Left)) yield return node;
            if (current.Right != null)
                foreach (var node in PostOrderTraversal(current.Right)) yield return node;
            
            yield return current;
        }
    }
}
