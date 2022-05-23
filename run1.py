from types import MethodType
from flask import Flask, render_template, request,redirect , json , url_for,session
from flaskext.mysql import MySQL
from pymysql import NULL, cursors
from werkzeug.security import generate_password_hash,check_password_hash
from flask import session




mysql = MySQL()
app = Flask(__name__)
app.secret_key = '12369'
# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = ''
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)



@app.route("/")
def main():
    return render_template('Home.html')


@app.route("/home")
def logouadmin():
   session.pop('adminid')
   session.pop('adminusername')
   return render_template('Home.html')


@app.route("/home")
def logoutuser():
    # Remove session data, this will log the user out
   session.pop('loggedin')
   session.pop('id')
   session.pop('username')
#    session.pop('adminid')
#    session.pop('adminusername')
   # Redirect to login page
   return render_template('Home.html')

@app.route('/plans')
def plane_vew1():
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        _planid = int(request.args.get("plan"))
        cursor.callproc('hospital_plans', (_planid,) )
        dataa = cursor.fetchall()
        cursor.callproc('plans_review', (_planid,) )
        data = cursor.fetchall()

        return render_template('plans.html', daa = data ,  socks = dataa )
    except Exception as e:
        print(e)
        return render_template('Error-Page.html',error = str(e))

@app.route('/Signup')
def signup():
    return render_template('Signup.html')

@app.route('/signUpUser',methods=['POST'])
def signUpuser():
    conn = mysql.connect()
    cursor = conn.cursor()
    # read the posted values from the UI
    _f_name = request.form['firstName']
    _l_name = request.form['lastName']
    #_plan = request.form['plan']
    if request.form['plan'] == 'Basic':
         _plan = 1
    elif  request.form['plan'] == 'Premium':
          _plan = 2
    elif  request.form['plan'] == 'Golden': 
         _plan = 3
    _name = request.form['userName']
    _password = request.form['password']
    _gv = request.form['government']
    _city = request.form['city']
    _phone = request.form['phone']
    _card = request.form['card']
    _exp_date = request.form['exp_date']
    _cvv = request.form['CVV']



   
    cursor.callproc('signup',(_f_name,_l_name,_plan,_name,_password,_gv,_city,_card,_exp_date,_cvv,_phone))
    data = cursor.fetchall()
    print(data)

 
    if len(data) is 0:
        conn.commit()
        print('ok')
        return  render_template('Error-Page.html',error = 'User created successfully !')
    else:
        return render_template('Error-Page.html',error = str(data[0]))
 

@app.route('/User-Login')
def userSignin():
    return render_template('User-Login.html')


@app.route("/validateLoginUser", methods=['POST'])
def validateLogin():
    # global customer_id , admin_id
    try:
        _username = request.form['username']
        _password = request.form['password']

        con = mysql.connect()
        cursor = con.cursor()
        cursor.callproc('val_user',(_username,_password))
        data = cursor.fetchall()

        if len(data) > 0:
            
            if _password == str(data[0][8]):
                session['loggedin'] = True
                session['id'] = data[0][0]
                session['username'] = data[0][7]
                customer_id = session['id']
                print(customer_id)
                cursor.callproc('call_user_name',(customer_id,))
                data2  = cursor.fetchall()
                datas = data2[0]
                return render_template('User-Dashboard.html', name = datas)
            else:
                return render_template('Error-Page.html',error = 'Wrong user_name  or Password')
        else:
            return render_template('Error-Page.html',error = 'Wrong user_name  or Password')

    except Exception as e:
        print(e)
        return render_template('Error-Page.html', str(e))
    finally:
        cursor.close()
        con.close()

@app.route('/validateLoginUser')
def home_user():

    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        customer_id = session['id']
        cursor.callproc('call_admin_name',(customer_id,))
        data2  = cursor.fetchall()
        dataa = data2[0]
        return render_template('User-Dashboard.html', nameadmin=dataa )
    except Exception as e:
        print(e)
        return render_template('Error-Page.html',error = str(e))
    
@app.route('/Create-Claim')
def creatclaim():
   
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        customer_id = session['id']
        cursor.callproc('vew_hospital',(customer_id,))
        data = cursor.fetchall() 
        cursor.callproc('call_user_name',(customer_id,))
        data2  = cursor.fetchall()
        dataa = data2[0]
        return render_template('Create-Claim.html',  datas = data , name = dataa  )
    except Exception as e:
        return render_template('Error-Page.html',error = str(e))

@app.route('/creat_claim',methods=['POST'])
def creat_claim():

    conn = mysql.connect()
    cursor = conn.cursor()
    # read the posted values from the UI
    _price = request.form['total_price']
    # _plan = request.form['plan']
    _date = request.form['date']
    _description = request.form['textarea']
    _hospitalid = request.form['NAme']
    _customerid = request.form['cust_id']
    _customerid =  session['id']

    cursor.callproc('createclaim1',(_price,_date,_description,_hospitalid,_customerid))
    data = cursor.fetchall()

    if len(data) is 0:
        conn.commit()
        print("200-Ok")
        return render_template('Error-Page.html',error = 'claim created successfully !')
    else:
        return render_template('Error-Page.html',error = 'error404')

@app.route('/Hospitals-View')
def hospital_vew():

    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        customer_id = session['id']
        cursor.callproc('vew_hospital', (customer_id,) )
        data = cursor.fetchall()
        cursor.callproc('call_user_name',(customer_id,))
        data2  = cursor.fetchall()
        dataa = data2[0]
        return render_template('Hospitals-View.html',  socks = data , name=dataa )
    except Exception as e:
        print(e)
        return render_template('Error-Page.html',error = str(e))


@app.route('/Admin-Login')
def SigninAdmin():
    return render_template('Admin-Login.html')

@app.route('/validateLoginAdmin',methods=['POST'])
def validateLoginA():

    try:
        _username = request.form['username']
        _password = request.form['password']
        con = mysql.connect()
        cursor = con.cursor()
        cursor.callproc('val_admin',(_username,_password))
        data = cursor.fetchall()
        print(data[0])    
        if len(data) > 0:            
            if _password == str(data[0][4]):
                session['loggedin'] = True
                session['adminid'] = data[0][0]
                session['adminusername'] = data[0][3]
                admin_id = session['adminid']
                print(admin_id)
                admin_id = data[0][0]
                cursor.callproc('call_admin_name',(admin_id,))
                data2  = cursor.fetchall()
                datas = data2[0]
                return render_template('Admin-Dashboard.html', nameadmin= datas)
            else:
                return render_template('Error_page.html',error = 'Wrong user_name  or Password')
        else:
            return render_template('Error-Page.html',error = '404. Error.')


    except Exception as e:
        print(e)
        return render_template('Error-Page.html',error = str(e))
    finally:
        cursor.close()
        con.close()

@app.route('/validateLoginAdmin')
def home_admin():

    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        admin_id = session['adminid']
        cursor.callproc('call_admin_name',(admin_id,))
        data2  = cursor.fetchall()
        dataa = data2[0]
        return render_template('Admin-Dashboard.html', nameadmin=dataa )
    except Exception as e:
        print(e)
        return render_template('Error-Page.html',error = str(e))

@app.route('/Customer')
def coustomervew_control():
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('call_users')
        data = cursor.fetchall()
        admin_id = session['adminid']
        cursor.callproc('call_admin_name',(admin_id,))
        data2  = cursor.fetchall()
        dataa = data2[0]

        return render_template('Customer.html',  socks = data , nameadmin = dataa)
    except Exception as e:
        print(e)
        return render_template('Error-Page.html',error = str(e))

@app.route('/New-User')
def usercreat():
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        admin_id = session['adminid']
        cursor.callproc('call_admin_name',(admin_id,))
        data2  = cursor.fetchall()
        dataa = data2[0]
        return render_template('New-User.html' ,nameadmin = dataa )    
    except Exception as e:
        print(e)
        return render_template('Error-Page.html',error = str(e)) 

@app.route('/new_user',methods=['POST'])
def new_user():
    conn = mysql.connect()
    cursor = conn.cursor()
    _f_name = request.form['firstName']
    _l_name = request.form['lastName']
    if request.form['plan'] == 'Basic':
         _plan = 1
    elif  request.form['plan'] == 'Premium':
          _plan = 2
    elif  request.form['plan'] == 'Golden': 
         _plan = 3
    _name = request.form['userName']
    _password = request.form['password']
    _gv = request.form['government']
    _city = request.form['city']
    _adminid = request.form['_admin_id']
    _phone = request.form['phone']
    _adminid = session['adminid']
    cursor.callproc('adduser',(_f_name,_l_name,_plan,_name,_password,_gv,_city,_adminid,_phone))
    data = cursor.fetchall()
 
    if len(data) is 0:
        conn.commit()
        print('ok')
        return  render_template('Error-Page.html',error = 'User created successfully !')
    else:
        return render_template('Error-Page.html',error = str(data[0]))

@app.route('/Dependent')
def dependantvew_control():
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('call_dependent')
        data = cursor.fetchall()
        admin_id = session['adminid']
        cursor.callproc('call_admin_name',(admin_id,))
        data2  = cursor.fetchall()
        dataa = data2[0]
        return render_template('Dependent.html',  socks = data ,nameadmin = dataa)
    except Exception as e:
        print(e)
        return render_template('Error-Page.html',error = str(e))
   

@app.route('/New-Dependent')
def dependantadd():
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc('call_all_parent')
        data = cursor.fetchall()
        print(data)
        admin_id = session['adminid']
        cursor.callproc('call_admin_name',(admin_id,))
        data2  = cursor.fetchall()
        dataa = data2[0]
        return render_template('add-Depen.html',  datas = data , nameadmin = dataa )
    except Exception as e:
        print(e)
        return render_template('Error-Page.html',error = str(e))
   
@app.route('/new_Dependent',methods=['POST'])
def new_depen():
    conn = mysql.connect()
    cursor = conn.cursor()
    _f_name = request.form['firstName']
    _l_name = request.form['lastName']
    if request.form['plan'] == 'Basic':
         _plan = 1
    elif  request.form['plan'] == 'Premium':
          _plan = 2
    elif  request.form['plan'] == 'Golden': 
         _plan = 3
    _parent = request.form['NAme']
    _name = request.form['userName']
    _password = request.form['password']
    _gv = request.form['government']
    _city = request.form['city']
    _phone = request.form['phone']
    _adminid = request.form['_admin_id']
    _adminid = session['adminid'] 


   
    cursor.callproc('createdepnt',(_f_name,_l_name,_plan,_parent,_name,_password,_gv,_city,_adminid,_phone))
    data = cursor.fetchall()
 
    if len(data) is 0:
        conn.commit()
        print('ok')
        return  render_template('Error-Page.html',error = 'dedpendant created successfully !')
    else:
        return render_template('Error-Page.html',error = str(data[0]))

@app.route('/Hospital-Control')
def Hospital_control():
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        
        cursor.callproc('hospital_with_plans')
        data = cursor.fetchall()
        admin_id = session['adminid']
        cursor.callproc('call_admin_name',(admin_id,))
        data2  = cursor.fetchall()
        dataa = data2[0]
        return render_template('Hospital-Control.html',  socks = data , nameadmin = dataa )
    except Exception as e:
        print(e)
        return render_template('Error-Page.html',error = str(e))
    

@app.route('/New-Hospital')
def ADD_Hospital(): 
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        admin_id = session['adminid']
        cursor.callproc('call_admin_name',(admin_id,))
        data2  = cursor.fetchall()
        dataa = data2[0]
        return render_template('newhospital.html', nameadmin = dataa )
    except Exception as e:
        print(e)
        return render_template('Error-Page.html',error = str(e))

@app.route('/new_Hospital',methods=['POST'])
def new_hospital():
    conn = mysql.connect()
    cursor = conn.cursor()
    _name = request.form['name']
    _HospitalKind = request.form['Hospital_Kind']
    _Specialities = request.form['Specialities']
    _gv = request.form['government']
    _city = request.form['city']
    _adminid = request.form['_admin_id']
    _adminid =  session['adminid']


   
    cursor.callproc('createhosp',(_name,_Specialities,_HospitalKind,_gv,_city,_adminid))
    print(cursor.callproc('createhosp',(_name,_Specialities,_HospitalKind,_gv,_city,_adminid)))
    cursor.execute(f"select hospital_id from project2.hospitals where hospital_name = '{_name}' ")
    hospitall_id = cursor.fetchone()[0]
    conn.commit()
  
    
    if request.form.get('basic') :
        _planid = 1        
        cursor.callproc('createhospitalhas',(_planid,hospitall_id))

    if request.form.get('premium') :
        _planid = 2       
        cursor.callproc('createhospitalhas',(_planid,hospitall_id))           
    if request.form.get('golden') :
        _planid = 3        
        cursor.callproc('createhospitalhas',(_planid,hospitall_id))
    conn.commit()   

    data = cursor.fetchall()
 
    if len(data) is 0:
        conn.commit()
        print('ok')
        return  render_template('Error-Page.html',error = 'Hospital created successfully !')
    else:
        return render_template('Error-Page.html',error = str(data[0]))    

@app.route('/Claim-Review')
def claim_rivew():
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        admin_id = session['adminid']
        cursor.callproc('claim_all')
        data = cursor.fetchall()
        cursor.callproc('call_admin_name',(admin_id,))
        data2  = cursor.fetchall()
        dataa = data2[0]
        return render_template('Claim-Review.html',  socks = data , nameadmin = dataa )
    except Exception as e:
        print(e)
        return render_template('Error-Page.html',error = str(e))

@app.route('/Claim-Action', methods=['GET', 'POST'])
def claimunsolved_rivew():
    try:
        conn = mysql.connect()
        cursor = conn.cursor()
        if request.method == 'POST': 
            _f_name = request.form.get('_f_name')
            id = request.form.get('id')
            cursor.callproc('usolved',(_f_name,id))
        cursor.callproc('claim_unsolved')
        data = cursor.fetchall()
        admin_id = session['adminid']
        cursor.callproc('call_admin_name',(admin_id,))
        data2  = cursor.fetchall()
        dataa = data2[0]
        return render_template('Claim_Action.html',  socks = data , nameadmin = dataa )
    except Exception as e:
        print(e)
        return render_template('Error-Page.html',error = str(e))

# @app.route('/usolved', methods=['POST'])
# def unsolved_claim():
#     print("hello")
#     global customer_id , admin_id 
    
#     try:
#         conn = mysql.connect()
#         cursor = conn.cursor()               

#         _f_name = request.form.get('_f_name')
#         id = request.form.get('id')
#         # print(_id)
#         cursor.callproc('usolved',(_f_name,id))
#         return redirect(url_for("claimunsolved_rivew"))
#     except Exception as e:
#         print(e)
#         return render_template('Error-Page.html',error = str(e))
# def contact():
#     if request.method == 'POST':
#        print("request.form")
#     elif request.method == 'GET':
#         return render_template('contact.html')
if __name__ == "__main__":
    app.run(port=9000)
