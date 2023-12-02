/*
Name: Ronick Shellman
Course: CNT 4714 - Fall 2023
Assignment title: A Three-Tier Distributed Web-Based Application
Date: Dec 2, 2023

*/

public class ResultObject {

    public String[] columnTitles;
    public String[][] rowData;

    public ResultObject(String[] columnNames, String[][] rowsSet, int rows, int columns) {
        this.columnTitles = columnNames;
        this.rowData = rowsSet;
    }
}