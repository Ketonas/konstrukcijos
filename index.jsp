<!DOCTYPE html>
<title>Konstrukcijos</title>
<head>
<%@page pageEncoding="UTF-8" language="java"%>
<%@page contentType="text/html;charset=UTF-8"%>
<%@page language="java" import="commons.Crud1" %>
<%
String id = request.getParameter("userid");
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "konstrukcijos";
String userId = "root";
String password = "";

String[] produktai = { "id", "pav", "rusis", "atsp_klase"  };
String[] reiksmes_produktai = new String [ produktai.length ];

Crud1 produktai_crud = new Crud1 ( dbName, userId, password, connectionUrl, "produktai", produktai );

%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<style>
 label, input { display:block; }
    input.text { margin-bottom:12px; width:95%; padding: .4em; }
    fieldset { padding:0; border:0; margin-top:25px; }
    h1 { font-size: 1.2em; margin: .6em 0; }
    div#users-contain { width: 350px; margin: 20px 0; }
    div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
    div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
    .ui-dialog .ui-state-error { padding: .3em; }
    .validateTips { border: 1px solid transparent; padding: 0.3em; }
body {
	background-image: url('https://793841.smushcdn.com/2005102/wp-content/uploads/visionline.jpg?lossy=1&strip=1&webp=1');
	font-family: arial black;
	background-repeat: no-repeat;
	background-size:cover;
	background-attachment:fixed;
	background-position:center;
	background-color:black;
}
#customers {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}
#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}
#customers tr:nth-child(even){background-color: #f2f2f2;}
#customers tr:hover {background-color: #ddd;}
#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: powderblue;
  color: white;
}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 <script>
  $( function() {
    var dialog, form,
 
      // From http://www.whatwg.org/specs/web-apps/current-work/multipage/states-of-the-type-attribute.html#e-mail-state-%28type=email%29
      emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
      id = $( "#id" ),
      pav = $( "#pav" ),
      rusis = $( "#rusis" ),
      atsp_klase = $( "#atsp_klase" ),
      allFields = $( [] ).add( id ).add( pav ).add( rusis ).add( atsp_klase ),
      tips = $( ".validateTips" );
 
    function updateTips( t ) {
      tips
        .text( t )
        .addClass( "ui-state-highlight" );
      setTimeout(function() {
        tips.removeClass( "ui-state-highlight", 1500 );
      }, 500 );
    }
 
    function checkLength( o, n, min, max ) {
      if ( o.val().length > max || o.val().length < min ) {
        o.addClass( "ui-state-error" );
        updateTips( "Length of " + n + " must be between " +
          min + " and " + max + "." );
        return false;
      } else {
        return true;
      }
    }
 
    function checkRegexp( o, regexp, n ) {
      if ( !( regexp.test( o.val() ) ) ) {
        o.addClass( "ui-state-error" );
        updateTips( n );
        return false;
      } else {
        return true;
      }
    }
 
    function addProduktai() {
      var valid = true;
      allFields.removeClass( "ui-state-error" );
 
      valid = valid && checkLength( id, "id", 1, 1000 );
      valid = valid && checkLength( pav, "pav", 1, 1000 );
      valid = valid && checkLength( rusis, "rusis", 1, 1000 );
      valid = valid && checkLength( atsp_klase, "atsp_klase", 1, 1000 );
 
      valid = valid && checkRegexp( id, /^([0-9a-zA-Z])+$/, "Username may consist of a-z, 0-9, underscores, spaces and must begin with a letter." );
      valid = valid && checkRegexp( pav, /^[a-z]([0-9a-z_\s])+$/i, "Username may consist of a-z, 0-9, underscores, spaces and must begin with a letter." );
      valid = valid && checkRegexp( rusis,  /^[a-z]([0-9a-z_\s])+$/i, "Username may consist of a-z, 0-9, underscores, spaces and must begin with a letter." );
      valid = valid && checkRegexp( atsp_klase, /^([0-9a-zA-Z])+$/, "Password field only allow : a-z 0-9" );
 
      if ( valid ) {
        $("#prekes_forma").submit();
        dialog.dialog( "close" );
      }
      return valid;
    }
 
    dialog = $( "#dialog-form" ).dialog({
      autoOpen: false,
      height: 400,
      width: 350,
      modal: true,
      buttons: {
        "Pridėti": addProduktai,
        "Atšaukti": function() {
          dialog.dialog( "close" );
        }
      },
      close: function() {
        form[ 0 ].reset();
        allFields.removeClass( "ui-state-error" );
      }
    });
 
    $( "#create-user" ).button().on( "click", function() {
      dialog.dialog( "open" );
    });


    $('.record_edit').click(function(){
		  id_rec=$(this).data('id_rec');
			if (mygtukas = document.getElementById ('toEdit_' + id_rec) ) {
<%				
					for ( int i=0; i<produktai.length; i++) {
%>
					document.getElementById('<%=produktai [ i ] %>').value= mygtukas.dataset.<%=produktai [ i ] %>;
<%
					}
%>
            document.getElementById ( "id" ).value = id_rec;
            dialog.dialog( "open" );
      }
    });
	  
  });

	

			  function iValyma () {
<%
				
				for ( int i=1; i<produktai.length; i++) {
%>
				
				  document.getElementById('<%=produktai [ i ] %>').value= "";
<%				
				}
%>
				
			}

				function iTrinima ( id_rec ) {
			
				mygtukasEdit = document.getElementById ( 'toDelete_' + id_rec );
				
				pav = mygtukasEdit.dataset.pav;
				
				var r = confirm( "Ar norite pašalinti užsakymą?" + pav + "?" );
				
				if ( r == true ) {
					
					document.getElementById ( "m_del" ).value = id_rec;
					
					forma_del = document.getElementById ( "del_rec" );

					forma_del.submit();
				}
				
			}

</script>
</head>

<html>
<body>
<center>
<h1 style="color:powderblue;"><b>Konstrukcijos</b></h1>
<table id="customers" border="1">
<tr>
<th style="text-align: center; vertical-align: middle;">Id</td>
<th style="text-align: center; vertical-align: middle;">Pavadinimas</th>
<th style="text-align: center; vertical-align: middle;">Rūšis</th>
<th style="text-align: center; vertical-align: middle;">Atsparumo klasė</th>
<th colspan=2></th>
</tr>
<%

try {
              
  request.setCharacterEncoding("UTF-8");
  response.setContentType("text/html; charset=UTF-8");
  response.setCharacterEncoding("UTF-8");		
  
      } catch(Exception e) {}

  
try { 
   
      
      String add = "";
      
      String sql_ins = "";
  
      if ( ( ( add = request.getParameter("add") ) != null ) && add.equals ( "Prideti" ) ) {

          String id_produkto = request.getParameter ("id");

          for ( int i=0; i<produktai.length; i++ ) {

            reiksmes_produktai [ i ] = request.getParameter ( produktai [ i ] );
          }
          
          if ( (id_produkto==null) || id_produkto.equals ("0") ) {

            produktai_crud.papildyti (reiksmes_produktai);

          } else {

            produktai_crud.update(reiksmes_produktai, id_produkto);
          }
      }

      String del = "";

		      if ( ( (  del = request.getParameter( "del" ) ) != null) && del.equals ( "del1rec" ) ) {	

            String id_produkto = "0";

            id_produkto = request.getParameter( "id_produkto" );

			    	produktai_crud.delete ( id_produkto );
			}
            
    } catch ( Exception e ) {
                    
        e.printStackTrace();
    }
      out.println( produktai_crud.lentele() );
%> 
</table> 


  <form id="del_rec" method="post" action="">
    <input type="hidden" name="del" value="del1rec">
    <input type="hidden" id="m_del" name="id_produkto" value="0">
	</form>

<div id="dialog-form" title="Pridėti norimus produktus">
  <p class="validateTips">Privaloma užpildyti visus laukelius</p>
 
  <form id="prekes_forma" method="post">
    <fieldset>

      <input type="hidden" name="id" id="id" value="0" class="text ui-widget-content ui-corner-all">
	  <label for="name">Pavadinimas</label>
      <input type="text" name="pav" id="pav" value="" class="text ui-widget-content ui-corner-all">
	  <label for="name">Rūšis</label>
      <input type="text" name="rusis" id="rusis" value="" class="text ui-widget-content ui-corner-all">
	  <label for="name">Atsparumo klasė</label>
      <input type="text" name="atsp_klase" id="atsp_klase" value="" class="text ui-widget-content ui-corner-all">
    <input type="hidden" name="add" id="add" value="Prideti">

      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    </fieldset>
  </form>           
</div>
    <button id="create-user">Formuoti užsakymą</button>
</body>
</html>