using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ParcelSorting
{
    public class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");

            ParcelLine(boxSizes);
        }

        public static bool ParcelLine(List<BoxSize> boxSizes)
        {
            bool parcelFits = false;

            foreach (BoxSize box in boxSizes)
            {
                Console.WriteLine("New sorting line starts");

                var boxLengthInHalf = box.Length / 2;
                var halfBoxDiagonalNotSqrt = (boxLengthInHalf * boxLengthInHalf) + (box.Width * box.Width);
                var halfParcelDiagonal = Math.Sqrt(halfBoxDiagonalNotSqrt);

                var lineWidth = 0;

                foreach (SortingLineParam sortingLine in box.SortingLineParams)
                {
                    var sortingLineNoSqrt = (sortingLine.Width * sortingLine.Width) + (lineWidth * lineWidth);
                    var cornerDiagonal = Math.Sqrt(sortingLineNoSqrt);

                    var maxHeight = Math.Sqrt((lineWidth * lineWidth) - (box.Width * box.Width));
                    var smallHeight = box.Length - maxHeight;
                    var smallDiagonal = Math.Sqrt((smallHeight * smallHeight) + (box.Width * box.Width));


                    if (sortingLine.Width >= halfParcelDiagonal)
                    {
                        Console.WriteLine("Sorting line width is {0} and fits", sortingLine.Width);
                    }
                    //else if (sortingLine.Width >= box.Width || sortingLine.Width >= box.Length)
                    //{
                    //    Console.WriteLine("Sorting line width is {0} and fits", sortingLine.Width);
                    //}
                    else if (sortingLine.Width <= halfParcelDiagonal && lineWidth >= halfParcelDiagonal)
                    {
                        Console.WriteLine("Sorting line width is {0} and fits", sortingLine.Width);
                    }
                    else if (sortingLine.Width >= smallDiagonal)
                    {
                        Console.WriteLine("Sorting line width is {0} and fits", sortingLine.Width);
                    }
                    else if (sortingLine.Width <= halfParcelDiagonal && sortingLine.Width >= cornerDiagonal)
                    {
                        parcelFits = sortingLine.Width <= halfParcelDiagonal && sortingLine.Width >= cornerDiagonal;

                        var result = parcelFits
                            ? "Sorting line width is " + sortingLine.Width + " and it fits" :
                            "It dosent fit to the sorting line and needs to be wider";
                        Console.WriteLine(result);
                    }
                    else
                    {
                        Console.WriteLine("It dosent fit to the sorting line and needs to be wider");
                    }

                    lineWidth = sortingLine.Width;

                }

                Console.WriteLine("\n");

            }

            return parcelFits;
        }

        public static readonly List<BoxSize> boxSizes = new List<BoxSize>
        {
            new BoxSize
            {
                Length = 120,
                Width = 60,
                SortingLineParams = new List<SortingLineParam>
                {
                    new SortingLineParam
                    {
                        Width = 100
                    },
                    new SortingLineParam
                    {
                        Width = 75
                    }
                }
            },
            new BoxSize
            {
                Length = 100,
                Width = 35,
                SortingLineParams = new List<SortingLineParam>
                {
                    new SortingLineParam
                    {
                        Width = 75
                    },
                    new SortingLineParam
                    {
                        Width = 50
                    },
                    new SortingLineParam
                    {
                        Width = 80
                    },
                    new SortingLineParam
                    {
                        Width = 100
                    },
                    new SortingLineParam
                    {
                        Width = 37
                    }
                }
            },

            new BoxSize
            {
                Length = 70,
                Width = 50,
                SortingLineParams = new List<SortingLineParam>
                {
                    new SortingLineParam
                    {
                        Width = 60
                    },
                    new SortingLineParam
                    {
                        Width = 60
                    },
                    new SortingLineParam
                    {
                        Width = 55
                    },
                    new SortingLineParam
                    {
                        Width = 90
                    }
                }
            }
        };
    }

    public class BoxSize
    {
        public int Length { get; set; }
        public int Width { get; set; }
        public List<SortingLineParam> SortingLineParams { get; set; }
            = new List<SortingLineParam>();
    }

    public class SortingLineParam
    {
        public int Width { get; set; }
    }
}