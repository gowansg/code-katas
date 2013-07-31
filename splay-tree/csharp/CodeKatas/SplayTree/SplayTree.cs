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
                if (comparsionResult < 0) current = current.Left;
                if (comparsionResult > 0) current = current.Right;
            }

            return null;
        }

        private string PrintTreeInOrder(Node<T> current, StringBuilder builder)
        {
            if (current.Left != null) PrintTreeInOrder(current.Left, builder);
            builder.Append(current.Value);
            if(current.Right != null) PrintTreeInOrder(current.Right, builder);

            return builder.ToString();
        }

        private string PrintTreePreOrder(Node<T> current, StringBuilder builder)
        {
            builder.Append(current.Value);
            if (current.Left != null) PrintTreePreOrder(current.Left, builder);
            if (current.Right != null) PrintTreePreOrder(current.Right, builder);

            return builder.ToString();
        }

        private string PrintTreePostOrder(Node<T> current, StringBuilder builder)
        {
            if (current.Left != null) PrintTreePostOrder(current.Left, builder);
            if (current.Right != null) PrintTreePostOrder(current.Right, builder);
            builder.Append(current.Value);

            return builder.ToString();
        }

        public override string ToString()
        {
            return ToString(TreeTraversal.InOrder);
        }

        public string ToString(TreeTraversal travesalMethod)
        {
            switch (travesalMethod)
            {
                case TreeTraversal.InOrder:
                    return PrintTreeInOrder(_root, new StringBuilder());
                case TreeTraversal.PreOrder:
                    return PrintTreePreOrder(_root, new StringBuilder());
                case TreeTraversal.PostOrder:
                    return PrintTreePostOrder(_root, new StringBuilder());
                default:
                    return PrintTreeInOrder(_root, new StringBuilder());
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
