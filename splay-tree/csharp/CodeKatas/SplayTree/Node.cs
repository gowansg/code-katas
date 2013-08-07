namespace SplayTree
{
    public class Node<T>
    {
        public T Value { get; internal set; }
        public Node<T> Parent { get; internal set; }
        public Node<T> Left { get; internal set; }
        public Node<T> Right { get; internal set; }

        public Node(T value)
        {
            Value = value;
        }
    }
}
