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
            
            [Test]
            public void CanIterateThroughTheTreeUsingInOrderTraversal()
            {
                var expectedValues = _tree.ToString(TreeTraversal.InOrder)
                                          .Split(',')
                                          .Select(int.Parse)
                                          .ToArray();
                var count = 0;
                foreach (var node in _tree.Traverse(TreeTraversal.InOrder))
                {
                    Assert.AreEqual(expectedValues[count], node.Value);
                    count++;
                }
                //todo: use _tree.Count when implemented
                Assert.AreEqual(10, count);
            }

            [Test]
            public void CanIterateThroughTheTreeUsingPreOrderTraversal()
            {
                var expectedValues = _tree.ToString(TreeTraversal.PreOrder)
                                          .Split(',')
                                          .Select(int.Parse)
                                          .ToArray();
                var count = 0;
                foreach (var node in _tree.Traverse(TreeTraversal.PreOrder))
                {
                    Assert.AreEqual(expectedValues[count], node.Value);
                    count++;
                }

                Assert.AreEqual(10, count);
            }

            [Test]
            public void CanIterateThroughTheTreeUsingPostOrderTraversal()
            {
                var expectedValues = _tree.ToString(TreeTraversal.PostOrder)
                                          .Split(',')
                                          .Select(int.Parse)
                                          .ToArray();
                var count = 0;
                foreach (var node in _tree.Traverse(TreeTraversal.PostOrder))
                {
                    Assert.AreEqual(expectedValues[count], node.Value);
                    count++;
                }

                Assert.AreEqual(10, count);
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
        }
    }
}
