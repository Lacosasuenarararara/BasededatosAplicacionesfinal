/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package edu.mx.uttt.bdapp.model;
import edu.mx.uttt.bdapp.entidades.Cliente;
import java.sql.Connection;
import edu.mx.uttt.bdapp.conexion.Conexion;
import java.sql.PreparedStatement;
import java.sql.SQLException;


/**
 *
 * @author Usuario
 */
public class ModelCliente {
    public static boolean agregar(Cliente cli){
        boolean sentinel = false;
        Connection con = Conexion.conectar();
        PreparedStatement pst = null;
        
        String query = "INSERT INTO [dbo].[Customers]\n" +
"           ([CustomerID]\n" +
"           ,[CompanyName]\n" +
"           ,[ContactName]\n" +
"           ,[ContactTitle]\n" +
"           ,[Address]\n" +
"           ,[City]\n" +
"           ,[Region]\n" +
"           ,[PostalCode]\n" +
"           ,[Country]\n" +
"           ,[Phone]\n" +
"           ,[Fax])\n" +
"     VALUES(?,?,?,?,?,?,?,?,?,?,?)";
        
        try{
            pst = con.prepareStatement(query);
            pst.setString(1, cli.getCustomerId());
            pst.setString(2, cli.getCompanyName());
            pst.setString(3, cli.getContactName());
            pst.setString(4, cli.getContactTitle());
            pst.setString(5, cli.getAddress());
            pst.setString(6, cli.getCity());
            pst.setString(7, cli.getRegion());
            pst.setString(8, cli.getPostalCode());
            pst.setString(9, cli.getCountry());
            pst.setString(10, cli.getPhone());
            pst.setString(11, cli.getFax());
            
            //Ejecutar la consulta
            
            int numRows = pst.executeUpdate();
            
            if(numRows>0){
                System.out.println("El cliente se insertaron " + numRows + "registros");   
            }
            sentinel = true;
        } catch (SQLException e){
            System.out.println("error: " + e.getMessage());
        }

        return sentinel;
    }
}
