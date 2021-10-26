<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@300&display=swap" rel="stylesheet">

    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css">
 
    <!-- jQuery -->
    <script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.2.min.js"></script>
     
    <!-- DataTables -->
    <script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>


    <style>
        *{
            margin:0;
            padding:0;
            font-family: 'Cairo', sans-serif;
            box-sizing: border-box;
        }

        .form{
            max-width: 600px;
            width: 100%;
            background-color: rgb(183, 185, 163);
            margin: 30px auto;
            padding: 30px;
            box-shadow: 1px 1px 2px 1px rgba(0, 0, 0, 0.12) ;
            border-radius: 0.5em;
        }
        
        .title{
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 20px;
            color: azure;
            text-transform: uppercase;
            text-align: center;
        }
        .names{
            display: flex;
            justify-content: space-between;
            width: 100%;
        }


        form .input_field{
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            display: flex;
            justify-content: space-between;
        }

        .input_field_ar{
            flex-direction: row-reverse;
        }
        .niveau,.date{
            display: flex;
        }
        .niveau label{
            width: 145px;
            display: flex;
        }
        .input___145{
            width: calc(100% - 145px);
        }
        .buttons {
            display: flex;
            margin-left: auto;
            margin-right: auto;
            width: fit-content;
        }
        @media only screen and (max-width: 520px) {
            .names,form .input_field,.niveau,.date{
                flex-direction: column;
            }
            .input_field label,.input_field input{width:100%!important;}
            .input___145{
                width:100%;
            }
        }
        
    </style>
    <title>Login</title>

</head>
<body>

    <div class='form'>
        <h1 class="title">Login</h1>
        <form action="" method="post">
            <div class="names">
                <div class="input_field" >
                    <label for="fname"style="width: 54px;margin-right: 10px;">Nom</label>
                    <input type="text" name="fname" id="fname" required/>
                </div>
    
                <div class="input_field input_field_ar">
                    <label for="fname_arab" style="width: 110px;direction: rtl;" >الاسم الشخصي</label>
                    <input type="text" name="fname_arab" id="fname_arab" required/>
                </div>
            </div>
            <div class="names left">
                <div class="input_field">
                    <label for="lname" style="width: 54px;margin-right: 10px;">Prenom</label>
                    <input type="text" name="lname" id="lname"required/>
                </div>
                <div class="input_field input_field_ar" >
                    <label for="lname_arab" style="width: 110px;direction: rtl;">الاسم العائلي</label>
                    <input type="text" name="lname_arab" id="lname_arab"required/>
                </div>
            </div>
            <div class="input_field">
                <label for="cin">CIN</label>
                <input type="text" name="cin" id="cin" required  class="input___145"/>
            </div>

            <div class="input_field">
                <label for="email">E-mail</label>
                <input type="text" name="email" id="email" required  class="input___145"/>
            </div>
            
            <!-- if user selects etudiant show a hidden cne field-->

            <div class="input_field">
                <label for="date" style="width:145px">Date de naissance</label>
                <input type="datetime" name="date" id="date"  class="input___145">
            </div>
            <div class="input_field">
                <label for="role">Rôle</label>
                <select type="text" name="role" id="role" required onclick = "Toggle(this.value)" class="input___145">
                    <option value="adminstrateur" >Adminstrateur</option>
                    <option value="enseignant" >Enseignant</option>
                    <option value="Etudiant" >Etudiant</option>
                </select>
            </div>

            <div class="input_field hidden__input"  style="display:none">
                <label for="cne">CNE</label>
                <input type="text" name="cne" id="cne" required  class="input___145"/>
            </div>

            <div class="input_field hidden__input"   style="display:none"  >
                <label for="niveau" >Niveau</label>
                <input type="text" name="niveau" id="niveau" required class="input___145" />
            </div>

            <div class="input_field grade" >
                <label for="grade" >Grade</label>
                <input type="text" name="grade" id="grade" required class="input___145" />
            </div>


            <div class="input_field specialite" style="display:none" >
                <label for="specialite" >Spécialité</label>
                <input type="text" name="specialite" id="specialite" required class="input___145" />
            </div>

            <div class="input_field">
                <label for="tel">Telephone +212</label>
                <input type="tel" name="tel" id="tel"  placeholder="600550055" pattern="[1-9]{9}" required style=" width: calc(100% - 145px); "/>
            </div>

            <div class="buttons">
                <div class="submit">
                    <input type="submit" value="valider">
                </div>
                <div class="reset">
                    <input type="reset" value="annuler">
                </div>
            </div>
        </form>
    </div>


    <script>


        $(function () {
            function showAdmin(){
                console.log('is it working admin')
                $('.input_field .grade').slideDown(500)
            }

            function showTeacher(){
                $(".hidden__input").slideUp(500);
            }


        });
        function Toggle(val){
            switch (val) {
                case 'adminstrateur':
                    $('.grade').slideDown(500)
                    $(".hidden__input").slideUp(500);
                    $('.specialite').hide()
                    break;
                case 'enseignant':
                    $('.specialite').slideDown(500)
                    $(".hidden__input").slideUp(500);
                    $('.grade').hide()
                    break;

                case 'Etudiant':
                    $('.grade').hide()
                    $('.specialite').hide()
                    $('.hidden__input').slideDown(500)
                    break;            
                
                default:
                    break;
            }
        }
    </script>

</body>
</html>