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

        public SplayTree(T[] values)
        {
            _root = BuildTreeFromRange(values);
        }

        private Node<T> BuildTreeFromRange(T[] values)
        {
            //todo: sort the list first
            if (values.Length == 0) return null;

            var middle = values.Length / 2;
            var newNode = new Node<T>(values[middle]);

            var rightSubtree = values.Skip(middle + 1)
                                    .Take(values.Length - middle + 1)
                                    .ToArray();
            newNode.Right = BuildTreeFromRange(rightSubtree);

            var leftSubtree = values.Take(middle).ToArray();
            newNode.Left = BuildTreeFromRange(leftSubtree);

            return newNode;
        }

        public Node<T> Search(T value)
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

        private string PrintTreeInOrder(Node<T> current, List<T> builder)
        {
            if (current.Left != null) PrintTreeInOrder(current.Left, builder);
            
            builder.Add(current.Value);

            if(current.Right != null) PrintTreeInOrder(current.Right, builder);

            return String.Join(",", builder);
        }

        private string PrintTreePreOrder(Node<T> current, List<T> builder)
        {
            builder.Add(current.Value);
            
            if (current.Left != null) PrintTreePreOrder(current.Left, builder);
            if (current.Right != null) PrintTreePreOrder(current.Right, builder);

            return String.Join(",", builder);
        }

        private string PrintTreePostOrder(Node<T> current, List<T> builder)
        {
            if (current.Left != null) PrintTreePostOrder(current.Left, builder);
            if (current.Right != null) PrintTreePostOrder(current.Right, builder);
            
            builder.Add(current.Value);

            return String.Join(",", builder);
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
                    return null;
            }
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

        public override string ToString()
        {
            return ToString(TreeTraversal.InOrder);
        }

        public string ToString(TreeTraversal traversalMethod)
        {
            var list = new List<T>();
            switch (traversalMethod)
            {
                case TreeTraversal.InOrder:
                    return PrintTreeInOrder(_root, list);
                case TreeTraversal.PreOrder:
                    return PrintTreePreOrder(_root, list);
                case TreeTraversal.PostOrder:
                    return PrintTreePostOrder(_root, list);
                default:
                    return PrintTreeInOrder(_root, list);
            }
        }
    }

    public enum TreeTraversal
    {
        InOrder,
        PreOrder,
        PostOrder
    }

    public class Node<T>
    {
        public T Value { get; set; }
        public Node<T> Left { get; set; }
        public Node<T> Right { get; set; }

        public Node(T value)
        {
            Value = value;
        }
    }
}
