<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%
    String nome = request.getParameter("txtnome");
    String email = request.getParameter("txtemail");
    String telefone = request.getParameter("telefone");
    String ajuda = request.getParameter("ajuda");

    String driver = "com.mysql.jdbc.Driver"; 
    String url = "jdbc:mysql://localhost:3306/paviweb"; 
    String usuario = "root"; // 
    String senha = ""; 

    Connection conexao = null;
    PreparedStatement stm = null;


        
        Class.forName(driver);
        
       
        conexao = DriverManager.getConnection(url, usuario, senha);


        String sql = "INSERT INTO voluntarios (nome, email, telefone, ajuda) VALUES (?, ?, ?, ?)";
        
      
        stm = conexao.prepareStatement(sql);
        stm.setString(1, nome);
        stm.setString(2, email);
        stm.setString(3, telefone);
        stm.setString(4, ajuda);

      
        stm.execute();
        
       
        stm.close();
        
        out.print("<h3>Dados gravados com sucesso!</h3>");
                conexao.close();
%>
