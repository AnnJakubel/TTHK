using ParcelSorting;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BoxSortingLine_Test
{
    public class BoxSortingTest
    {
        [Fact]
        public void When_ParcelHasNewDimensionsAndSortingLineHasNewDimensions_Then_PrcelCanNotFindSortingLine()
        {
            var boxSizes = new List<BoxSize>()
            {
                new BoxSize()
                {
                    Length = 70,
                    Width = 100,
                    SortingLineParams = new List<SortingLineParam>
                    {
                        new SortingLineParam
                        {
                            Width = 5
                        },
                        new SortingLineParam
                        {
                            Width = 16
                        },
                        new SortingLineParam
                        {
                            Width = 25
                        },
                        new SortingLineParam
                        {
                            Width = 9
                        }
                    }
                }
            };

            bool result = Program.ParcelLine(boxSizes);

            Assert.False(result);
        }
    }
}
