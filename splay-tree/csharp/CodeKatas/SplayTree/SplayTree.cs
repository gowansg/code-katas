using System;
using System.Collections.Generic;
using System.Linq;

namespace SplayTree
{
    public class SplayTree<T> where T : IComparable<T>
    {
        private Node<T> _root;

        public int Balance
        {
            get { return _root == null ? 0 : _root.GetBalance(); }
        }

        public SplayTree()
        {
        }

        public SplayTree(T[] values)
        {
            _root = BuildTreeFromValues(values);
        }

        private Node<T> BuildTreeFromValues(T[] values)
        {
            //todo: sort the list first
            if (values.Length == 0) return null;

            var middle = values.Length / 2;
            var newNode = new Node<T>(values[middle]);

            var rightSubtree = values.Skip(middle + 1)
                                     .Take(values.Length - middle + 1)
                                     .ToArray();
            newNode.Right = BuildTreeFromValues(rightSubtree);

            var leftSubtree = values.Take(middle).ToArray();
            newNode.Left = BuildTreeFromValues(leftSubtree);

            return newNode;
        }

        public Node<T> Find(T value)
        {
            return Find(_root, value);
        }

        private Node<T> Find(Node<T> node, T value)
        {
            if (node == null) return null;

            var comparisonResult = value.CompareTo(node.Value);

            if (comparisonResult == 0) return node;

            var pivot = comparisonResult < 0
                            ? Find(node.Left, value)
                            : Find(node.Right, value);

            if (pivot == null) return null;

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

        public void Add(T value)
        {
            AddNode(value);
            Rebalance();
        }

        private void AddNode(T value)
        {
            var current = _root;

            while (current != null)
            {
                var comparison = value.CompareTo(current.Value);
                if (comparison == 0) return;

                current = comparison < 0
                              ? current.Left ?? new Node<T>(value)
                              : current.Right ?? new Node<T>(value);
            }
        }

        private void Rebalance()
        {
            throw new NotImplementedException();
        }

        public void Add(IEnumerable<T> values)
        {
            foreach(var value in values) AddNode(value);
            Rebalance();
        }

        public void Delete(T value)
        {
            DeleteNode(value);
            Rebalance();
        }

        private void DeleteNode(T value)
        {
            var nodeToDelete = Search(value);
            
            if (nodeToDelete == null) return;

            if (nodeToDelete.Left != null && nodeToDelete.Right != null)
            {
                var largest = RemoveLargestValueFromTree(nodeToDelete.Left);
                nodeToDelete.Value = largest.Value;
                return;
            }
            
            if (nodeToDelete.Left != null)
            {
                nodeToDelete.Value = nodeToDelete.Left.Value;
                var leftChild = nodeToDelete.Left;
                while (leftChild != null)
                {
                    leftChild.Value = leftChild.Left.Value;
                    leftChild = leftChild.Left;
                }
            }

            if (nodeToDelete.Right != null)
            {
                nodeToDelete.Value = nodeToDelete.Right.Value;
                var rightChild = nodeToDelete.Right;
                while (rightChild != null)
                {
                    rightChild.Value = rightChild.Right.Value;
                    rightChild = rightChild.Right;
                }
            }
        }

        private Node<T> RemoveLargestValueFromTree(Node<T> node)
        {
            if (node == null || node.Right == null) return node;
            var largest = RemoveLargestValueFromTree(node.Right);
            if (largest.Right == null) node.Right = largest.Left;
            return largest;
        }

        private Node<T> Search(T value)
        {
            Node<T> current = _root;
            var comparison = value.CompareTo(current.Value);

            while (current != null)
            {
                if (comparison == 0) return current;
                current = comparison < 0 ? current.Left : current.Right;
            }

            return null;
        }

        public void Delete(IEnumerable<T> values)
        {
            foreach (var value in values) DeleteNode(value);
            Rebalance();
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

        private IEnumerable<Node<T>> PreOrderTraversal(Node<T> current)
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
