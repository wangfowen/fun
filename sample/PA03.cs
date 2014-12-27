// -------------------------------------------------------------------	
// Department of Electrical and Computer Engineering
// University of Waterloo
//
// Student Name:     Fang Wang
// UWDIR Userid:     f57wang
//
// Assignment:       Programming Assignment 3
// Submission Date:  November 14, 2010
// 
// I declare that, other than the acknowledgements listed below, 
// this program is my original work.
//
// Acknowledgements:
// 
// -------------------------------------------------------------------

using System;
using System.IO;

public class GridPoint
{
        private int row;
        private int column;
               
        public GridPoint(int row, int column)
        {
                this.row = row;
                this.column = column;
        }
                
        public int Row
        {
                get
                {
                        return row;
                }
        }
                
        public int Column
        {
                get
                {
                        return column;
                }
        }
                
        public override string ToString()
        {
                string s;
                s = string.Format("( {0,4}, {1,4} )", row, column);
                return s;
        }
}
        
public class ElevationModel
{ 
        private string title;
        private double[,] elevations;
                
        public ElevationModel(string inFileName)
        {
                ReadDem(inFileName); //ReadDem sets elevations and title
        }
                
        public string Title
        {
                get
                {
                        return title;
                }
        }
                
        public int Rows
        {
                get
                {
                        int rows = elevations.GetLength(0);
                        return rows;
                }
        }
        
        public int Columns
        {
                get
                {
                        int columns = elevations.GetLength(1);
                        return columns;
                }
        }
                
        public double Elevation(int row, int column)
        {
                double elevation = 0;
                
                try
                {
                        elevation = elevations[row, column];
                        //elevation at a particular grid cell
                }
                catch (IndexOutOfRangeException e)
                {
                        Console.WriteLine(e.Message);
                }

                return elevation;
        }
                
        public void ReadDem(string inFileName)
        {
                string str; //string read from file
                string[] array = null; //array of tokens split from string
                char[] separate = {','}; //delimiter
                int rows; //number of rows read from file
                int columns; //number of columns read from file
                StreamReader inFile; //file to be read
                
                try
                {
                        inFile = new StreamReader(inFileName);
                        title = inFile.ReadLine(); //title read frrom first line
                        rows = int.Parse(inFile.ReadLine());
                        columns = int.Parse(inFile.ReadLine());
                        elevations = new double[rows, columns];
                        
                        for (int i = 0; i < rows; i++)
                        {
                                str = inFile.ReadLine();
                                array = str.Split(separate);
                                
                                for (int j = 0; j < columns; j++)
                                {
                                        elevations[i, j] = 
                                          double.Parse(array[j]);
                                        //build array of elevations from
                                        //values read and split
                                }
                        }
                        
                        inFile.Close();
                }
                catch (IOException e)
                {
                        Console.WriteLine(e.Message);
                }        
        }
                
        public void WriteDem(string outFileName)
        {
                StreamWriter outFile;
                
                try
                {
                        outFile = new StreamWriter(outFileName);
                        outFile.WriteLine(title);
                        outFile.WriteLine(Rows);
                        outFile.WriteLine(Columns);
                        //write first three lines into new file
                        
                        for (int i = 0; i < Rows; i++)
                        {
                                for (int j = 0; j < Columns; j++)
                                {
                                        outFile.Write("{0},", 
                                          elevations[i, j]);
                                        //write elevation values into file
                                }
                                
                                outFile.WriteLine();
                        }
                        
                        outFile.Close();
                }
                catch (IOException e)
                {
                        Console.WriteLine(e.Message);
                }
        }
                
        public GridPoint[] Outliers()
        {
                int gridSize = 0; //size of GridPoint array
                double average; //average of values around particular cell
                int index = 0; //index of value in array
                GridPoint[] outlier; //GridPoint array of outliers
                
                for (int i = 0; i < Rows; i++)
                {
                        for (int j = 0; j < Columns; j++)
                        {
                                if ((i > 0 && j > 0) && 
                                  (i < Rows - 1 && j < Columns - 1))
                                {
                                        average = (elevations[i + 1, j + 1] +
                                          elevations[i + 1, j - 1] +
                                          elevations[i - 1, j + 1] +
                                          elevations[i - 1, j - 1] + 
                                          elevations[i + 1, j] + 
                                          elevations[i - 1, j] + 
                                          elevations[i, j + 1] +
                                          elevations[i, j - 1]) / 8d;
                                        //average of eight nearest neighbours
        
                                        if (Math.Abs(average - elevations[i,j])
                                          >= 100)
                                        {
                                                gridSize++;
                                                //increase outlier count when
                                                //difference greater than 100
                                        }
                                }
                        }
                }
                
                outlier = new GridPoint[gridSize];
                
                for (int i = 0; i < Rows; i++)
                {
                        for (int j = 0; j < Columns; j++)
                        {
                                if ((i > 0 && j > 0) &&
                                  (i < Rows - 1 && j < Columns - 1))
                                {
                                        average = (elevations[i + 1, j + 1] +
                                          elevations[i + 1, j - 1] +
                                          elevations[i - 1, j + 1] +
                                          elevations[i - 1, j - 1] + 
                                          elevations[i + 1, j] + 
                                          elevations[i - 1, j] + 
                                          elevations[i, j + 1] +
                                          elevations[i, j - 1]) / 8d;
                                        
                                        if (Math.Abs(average - elevations[i,j])
                                          >= 100)
                                        {
                                                outlier[index] =
                                                  new GridPoint(i, j);
                                                index++;
                                                //set values of array
                                        }
                                }
                        }
                }
                
                return outlier;
        }
                
        public void SmoothOutlier(int row, int column)
        {
                try
                {
                        elevations[row, column] = 
                          (elevations[row+ 1, column + 1] +
                          elevations[row + 1, column - 1] + 
                          elevations[row - 1, column + 1] +
                          elevations[row - 1, column - 1] + 
                          elevations[row + 1, column] + 
                          elevations[row - 1, column] + 
                          elevations[row, column + 1] +
                          elevations[row, column - 1]) / 8d;
                        //correction of elevation
                }
                catch (IndexOutOfRangeException e)
                {
                        Console.WriteLine(e.Message);
                }
        }
                
        public double Area(double elevation)
        {
                double area = 0;
                
                for (int i = 0; i < Rows; i++)
                {
                        for (int j = 0; j < Columns; j++)
                        {
                                if (elevations[i, j] <= elevation)
                                {
                                        area += .01; 
                                        //each cell is 100m*100m (0.1km*0.1km)
                                }
                        }
                }
                
                return area;
        }
                
        public double Volume(double elevation)
        {
                double volume = 0;
                
                for (int i = 0; i < Rows; i++)
                {
                        for (int j = 0; j < Columns; j++)
                        {
                                if (elevations[i, j] <= elevation)
                                {
                                        volume += elevations[i, j] * .00001;
                                        //elevation is in meters so convert to
                                        //km by divide by 1000, then multiply
                                        //that by area (.01) for volume
                                }
                        }
                }
                
                return Math.Abs(volume);
        }
}
        
public class Program
{
        static void Main()
        {
                string problemType = null; //cause of outlier
                ElevationModel  tahoe = new ElevationModel("TahoeDEM.csv");
                
                Console.WriteLine("Digital Elevation Model Analysis");
                Console.WriteLine("{0, 10}{1}", "Title: ", tahoe.Title);
                Console.WriteLine("{0, 10}{1}", "Rows: ", tahoe.Rows);
                Console.WriteLine("{0, 10}{1}", "Columns: ", tahoe.Columns);
                
                Console.WriteLine("\nDetected Outlier Cells");
                Console.WriteLine("{0, 11}{1, 16}{2, 10}", "Elevation",
                  "DEM Grid Cell", "Problem");
                  
                foreach(GridPoint outlier in tahoe.Outliers())
                {
                        if (tahoe.Elevation(outlier.Row, outlier.Column) > 0)
                        {
                                problemType = "Bird";
                                //outlier above surface are caused by birds
                        }
                        else if (tahoe.Elevation(outlier.Row, outlier.Column) 
                          < 0)
                        {
                                problemType = "Fish";
                                //outlier below surface are caused by fish
                        }
                                
                        Console.WriteLine("{0,9:F1} m{1,17}   {2}", 
                          tahoe.Elevation(outlier.Row, outlier.Column), 
                          outlier, problemType);
                }
                
                Console.WriteLine("\nCorrected Outlier Cells");
                Console.WriteLine("{0, 11}{1, 16}", "Elevation", 
                  "DEM Grid Cell");
                  
                foreach(GridPoint point in tahoe.Outliers())
                {
                        tahoe.SmoothOutlier(point.Row, point.Column);
                                
                        Console.WriteLine("{0,9:F1} m{1,17}", 
                          tahoe.Elevation(point.Row, point.Column), point);
                }
                
                tahoe.WriteDem("NewTahoeDEM.csv");
                //write corrected DEM into output file
                
                Console.WriteLine("\nLake Size Estimates");
                Console.WriteLine("{0, 9}{1, 5} square km", "Area:", 
                  Convert.ToInt32(tahoe.Area(0d)));
                Console.WriteLine("{0, 9}{1, 5} cubic km", "Volume:",
                  Convert.ToInt32(tahoe.Volume(0d)));             
        }
}