namespace SplayTree
{
    public class Node<T>
    {
        public T Value { get; internal set; }
        public Node<T> Left { get; internal set; }
        public Node<T> Right { get; internal set; }
        
        public Node(T value)
        {
            Value = value;
        }

        internal int GetBalance()
        {
            return (Right == null ? 0 : Right.GetBalance() + 1) 
                   - (Left == null ? 0 : Left.GetBalance() + 1);
        }
    }
}
