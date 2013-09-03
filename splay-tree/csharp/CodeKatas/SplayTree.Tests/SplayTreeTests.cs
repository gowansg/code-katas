using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace SplayTree.Tests
{
    [TestFixture]
    public class SplayTreeTests
    {
        [TestFixture]
        public class TheSplayTreeConstructorWithTheSingleArrayParameter
        {
            [Test]
            public void ReturnsASplayTreeContainingAllTheElementsInTheArray()
            {
                var tree = new SplayTree<int>(Enumerable.Range(0, 256).ToArray());
                var nodes = tree.ToString().Split(',').Select(int.Parse).ToArray();
                for (int i = 0; i < 256; i++) Assert.AreEqual(i, nodes[i]);
            }
        }
        
        [TestFixture]
        public class TheToStringMethod
        {
            private SplayTree<int> _tree = new SplayTree<int>(Enumerable.Range(0, 8).ToArray());

            [Test]
            public void DefaultsToAnInOrderRepresentationOfTheTree()
            {
                var result = _tree.ToString();
                Assert.AreEqual(result, "0,1,2,3,4,5,6,7");
            }

            [Test]
            public void CanProduceAPreOrderRepresentationOfTheTree()
            {
                var result = _tree.ToString(TreeTraversal.PreOrder);
                Assert.AreEqual(result, "4,2,1,0,3,6,5,7");
            }

            [Test]
            public void CanProduceAPostOrderRepresentationOfTheTree()
            {
                var result = _tree.ToString(TreeTraversal.PostOrder);
                Assert.AreEqual(result, "0,1,3,2,5,7,6,4");
            }

            [Test]
            public void CanProduceAnInOrderRepresentationOfTheTree()
            {
                var result = _tree.ToString(TreeTraversal.InOrder);
                Assert.AreEqual(result, "0,1,2,3,4,5,6,7");
            }
        }

        [TestFixture]
        public class TheTraverseMethod
        {
            private SplayTree<int> _tree = new SplayTree<int>(Enumerable.Range(1, 10).ToArray());

            private void TraverseUsing(TreeTraversal traversal)
            {
                var expectedValues = _tree.ToString(traversal)
                           .Split(',')
                           .Select(int.Parse)
                           .ToArray();

                var count = 0;
                foreach (var node in _tree.Traverse(traversal))
                {
                    Assert.AreEqual(expectedValues[count], node.Value);
                    count++;
                }
                //todo: use _tree.Count when implemented
                Assert.AreEqual(10, count);
            }

            [Test]
            public void CanIterateThroughTheTreeUsingInOrderTraversal()
            {
                TraverseUsing(TreeTraversal.InOrder);
            }

            [Test]
            public void CanIterateThroughTheTreeUsingPreOrderTraversal()
            {
                TraverseUsing(TreeTraversal.PreOrder);
            }

            [Test]
            public void CanIterateThroughTheTreeUsingPostOrderTraversal()
            {
                TraverseUsing(TreeTraversal.PostOrder);
            }
        }

        [TestFixture]
        public class TheFindMethod
        {
            [Test]
            public void PlacesTheMostRecentlySearchedNodeAtTheRootOfTheTree()
            {
                var tree = new SplayTree<int>(Enumerable.Range(1, 10).ToArray());
                var root = tree.ToString(TreeTraversal.PreOrder).First();
                Assert.AreNotEqual('1', root);

                tree.Find(1);
                root = tree.ToString(TreeTraversal.PreOrder).First();
                Assert.AreEqual('1', root);
            }

            [Test]
            public void ReturnsNullIfTheSearchTermCannotBeFound()
            {
                var tree = new SplayTree<int>(Enumerable.Range(1, 10).ToArray());
                Assert.AreEqual(null, tree.Find(11));
            }
        }

        [TestFixture]
        public class TheBalanceProperty
        {
            [Test]
            public void ReturnsAnIntegerIndicatingTheBalanceOfTheTree()
            {
                var tree = new SplayTree<int>(Enumerable.Range(5, 25).ToArray());
                Assert.AreEqual(0, tree.Balance);
            }
        }

        [TestFixture]
        public class TheAddMethod
        {
            [Test]
            public void AddsAGivenValueToTheSplayTree()
            {

            }
        }

        [TestFixture]
        public class TheDeleteMethod
        {
            [Test]
            public void RemovesTheGivenValueFromTheTree()
            {
                var tree = new SplayTree<int>(Enumerable.Range(100, 40).ToArray());
                tree.Delete(110);
                Assert.AreEqual(null, tree.Find(110));
            }
        }
    }
}
