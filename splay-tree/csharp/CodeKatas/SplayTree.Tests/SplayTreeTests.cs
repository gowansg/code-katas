using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace SplayTree.Tests
{
    public class SplayTreeTests
    {
        private static IEnumerable<int> GenerateListOfConsecutiveInts(int count)
        {
            var list = new List<int>();
            for (var i = 0; i < count; i++) list.Add(i);
            return list;
        }
        
        [TestFixture]
        public class TheSplayTreeConstructorWithTheSingleArrayParameter
        {
            [Test]
            public void ReturnsASplayTreeContainingAllTheElementsInTheArray()
            {
                var tree = new SplayTree<int>(GenerateListOfConsecutiveInts(256).ToArray());
                for (int i = 0; i < 256; i++) Assert.IsNotNull(tree.Search(i));
            }
        }
        
        [TestFixture]
        public class TheToStringMethod
        {
            private SplayTree<int> _tree = new SplayTree<int>(GenerateListOfConsecutiveInts(8).ToArray());

            [Test]
            public void DefaultsToAnInOrderRepresentationOfTheTree()
            {
                var result = _tree.ToString();
                Assert.AreEqual(result, "01234567");
            }

            [Test]
            public void CanProduceAPreOrderRepresentationOfTheTree()
            {
                var result = _tree.ToString(TreeTraversal.PreOrder);
                Assert.AreEqual(result, "42103657");
            }

            [Test]
            public void CanProduceAPostOrderRepresentationOfTheTree()
            {
                var result = _tree.ToString(TreeTraversal.PostOrder);
                Assert.AreEqual(result, "01325764");
            }

            [Test]
            public void CanProduceAnInOrderRepresentationOfTheTree()
            {
                var result = _tree.ToString(TreeTraversal.InOrder);
                Assert.AreEqual(result, "01234567");
            }
        }
    }
}
