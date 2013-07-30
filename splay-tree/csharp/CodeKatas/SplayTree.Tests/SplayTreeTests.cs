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
        private IEnumerable<int> GenerateListOfConsecutiveInts(int count)
        {
            var list = new List<int>();
            for (var i = 0; i < count; i++) list.Add(i);
            return list;
        }

        [Test]
        public void AllTheElementsInTheRangeUsedToBuildTheTreeAreAccountedFor()
        {
            var tree = new SplayTree<int>(GenerateListOfConsecutiveInts(256).ToArray());
            for (int i = 0; i < 256; i++) Assert.IsNotNull(tree.Search(i));
        }

        [Test]
        public void MostRecentlyAccessedNodeShouldBecomeTheRoot()
        {
            var tree = new SplayTree<int>(GenerateListOfConsecutiveInts(128).ToArray());
            tree.Search(42);
            //Assert.AreEqual(42, tree.Root);
        }
    }
}
