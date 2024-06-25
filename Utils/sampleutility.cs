using System;
using System.Collections.Generic;
using System.IO;

public class SampleUtility
{
    public static void MethodWithManyParameters(int p1, int p2, int p3, int p4, int p5, int p6, int p7, int p8, int p9, int p10, int p11)
    {
        // Method logic here
    }

    public static List<string> ReadCsvFile(string filePath)
    {
        List<string> lines = new List<string>();
        using (StreamReader reader = new StreamReader(filePath))
        {
            while (!reader.EndOfStream)
            {
                lines.Add(reader.ReadLine());
            }
        }
        return lines;
    }
}
