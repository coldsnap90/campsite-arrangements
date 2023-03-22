from memory_profiler import memory_usage,profile
from datetime import datetime


def func(p_id,p_id1):
    x = ''
    for i in p_id:
        x+=f'{i} '
    print(x)
    return x

def main():
    productKey = {'iann_mem_bronze':'price_1LulFpH3k8WZ4arfpPVjdNaq','jann_mem_silver':'price_1LulFpH3k8WZ4arfK3inXJDT',
        'kann_mem_gold':'price_1LulFpH3k8WZ4arfMXYgKtLI','lann_mem_plat':'price_1LulFpH3k8WZ4arfR98vyl3X','emon_mem_bronze':'price_1LkfreH3k8WZ4arfdAjDipjW',
        'fmon_mem_silver':'price_1LkfreH3k8WZ4arfskkvQ0xe','gmon_mem_gold':'price_1LkfreH3k8WZ4arfNXltBLeu','hmon_mem_plat':'price_1LkfreH3k8WZ4arfSBQ2CsXG','asingle_bronze':'price_1LkfvaH3k8WZ4arfyrGerqcx',
        'bsingle_silver':'price_1LkfvaH3k8WZ4arf4RGgHGHy','csingle_gold':'price_1LkfvaH3k8WZ4arfzmDwmYAD','dsingle_plat':'price_1LkfvaH3k8WZ4arfDyC5s06D'}
    x = 'jann_mem_silver' 
    y = 'kann_mem_gold'
    scan = 3
    plans = {'iann_mem_bronze':3,'jann_mem_silver':5,
        'kann_mem_gold':7,15:'price_1LulFpH3k8WZ4arfR98vyl3X','emon_mem_bronze':3,
        'fmon_mem_silver':5,'gmon_mem_gold':7,'hmon_mem_plat':15,'asingle_bronze':1,
        'bsingle_silver':1,'csingle_gold':1,'dsingle_plat':2}
    if plans['iann_mem_bronze'] <= scan:
        print('<=')

    subscription = 'price_1LkfvaH3k8WZ4arfyrGerqcx'
    if x in productKey and y in productKey:
        p_id = str(productKey[x])
        p_id1 = str(productKey[y])
    print(p_id, ' \\',p_id1)
        
    z = func(p_id,p_id1)

    mem_usage = memory_usage()
    print('Memory usage (in chunks of .1 seconds): %s' % mem_usage)
    print('Maximum memory usage: %s' % max(mem_usage))

    '''
    file_path ='./mem.txt'
    with open(file_path, 'w') as outfile:
        outfile.write('Memory usage (in chunks of .1 seconds): %s' % mem_usage)
        outfile.write('\nMax memory usage: %s' % max(mem_usage))
    outfile.close()    
    '''
def job_date(date_booking):
        if date_booking.month > ((datetime.now().month + 4)%12) and date_booking.year == datetime.now().year:
            date_booked = f'{date_booking.year}-{date_booking.month-4}-{date_booking.day}'
            start_day = f'{date_booked} 06:53:00'
            end_day = f'{date_booked} 19:59:00'
        elif date_booking.month <= ((datetime.now().month + 4)%12) and date_booking.year == datetime.now().year:
            print(datetime.now())
            date_booked = f'{datetime.now().year}-{datetime.now().month}-{datetime.now().day}'
            start_day = f'{date_booked} 06:53:00'
            end_day = f'{datetime.now().year}-{datetime.now().month}-{datetime.now().day+1} 19:59:00'
        elif date_booking.year > datetime.now().year:
            date_booked = f'{date_booking.year}-{date_booking.month-4}-{date_booking.day}'
            start_day = f'{date_booked} 06:53:00'
            end_day = f'{date_booked} 19:59:00'
        return start_day,end_day
if __name__ == '__main__'    :  
   x = datetime(2023,9,11).date()
   print(x)
   y = datetime(2024,8,13)
   z = datetime.now()

   a,b = job_date(x)
   print('SD - ',a,' ED - ' ,b)
   print('\n')
   a,b = job_date(y)
   print('SD - ',a,' ED - ' ,b)
   print('\n')
   a,b = job_date(z)
   print('SD - ',a,' ED - ' ,b)
'''
@auth.route('/tokentest',methods=['GET','POST'])
@login_required
def token_test():
    
    data = current_user.get_id()
    print('DATA : ',data)
    user = User.query.filter_by(id = data).first()
    newB = BookingData(park ='Porteau Cove',site='11',site_type='campsite',campground = 'A (Sites 1-37)',inner_campground=None,arrival_month='Jan',arrival_day='3',
                arrival_year = '2022',nights = '1',equiptment = '2 Tents',email = 'cheema_mandy@hotmail.com',password = 'Apple9314!!',
                party_size='1',contact_num=f'6046141826',booked = False,user_id=data)
    db.session.add(newB)
    db.session.commit()
    newB.send_link(user,newB)


    return redirect(url_for('auth.account_details'))

@auth.route('/addu',methods =['GET','POST'])
def addu():
                salted_password = bcrypt.generate_password_hash('1').decode('utf-8')
                new_user = User(email = 'frankcastle@gmail.com',password = salted_password,
                        firstName='frank',lastName='castle',confirmed=False,billingAddress=None,
                        postalCode=None,city =None,province = None,country = None,subscription = None,cId=None,sId=None,scan=None,
                        sub_day = None,phone_num = None)
                db.session.add(new_user)
                db.session.commit()
                salted_password = bcrypt.generate_password_hash('1').decode('utf-8')
                new_user = User(email = 'cheems@hotmail.com',password = salted_password,
                        firstName='jak',lastName='cheemo',confirmed=False,billingAddress=None,
                        postalCode=None,city =None,province = None,country = None,subscription = None,cId=None,sId=None,scan=None,
                        sub_day = None,phone_num = None)
                db.session.add(new_user)
                db.session.commit()
                return redirect(url_for('auth.dquery'))

@auth.route('/data',methods =['GET','POST'])
@login_required
def data():
    date = BookingData.query.all()
    for i in date:
        db.session.delete(i)
        db.session.commit()
    Account = User.query.filter_by(email = 'cfarbatuk@gmail.com').first()
    time = bookingTimeTest.query.all()
    for i in time:
        db.session.delete(i)
        db.session.commit()
    Account.is_admins()
    return render_template('data.html',site=date,campground = Account)

@auth.route('/bookings',methods=['GET','POST'])
def bookings():
    data = User.get_id(current_user)
    account = User.query.filter_by(id=data).all()
    time = bookingTimeTest.query.all()
    b = BookingData.query.filter_by(user_id =data).all()
    return render_template('data.html',data = data,campground = account,inner_Campground = time,bookings=b)

@auth.route('/adds',methods = ['GET','POST'])
@login_required
def adds():
    data = User.get_id(current_user)
    account_booking = BookingData.query.get_or_404(data)
    user = User.query.filter_by(id = data).first()
    user.add_scan(True)
    db.session.commit()
    return render_template('data.html',data = user)

@auth.route('/dels',methods = ['GET','POST'])
@login_required
def dels():
    data = User.get_id(current_user)
    user = User.query.filter_by(id = data).first()
    user.delete_scan()
    db.session.commit()
    print(user)
    return render_template('data.html',data = user)

@auth.route('/delU',methods = ['GET','POST'])
def delU():
    user = User.query.all()
    for i in User.query.all():
        if i == User.query.filter_by(email = 'cfarbatuk@gmail.com').first():
            print(' USER : ',i)

        elif i == User.query.filter_by(email='admin@admin.ca').first():
            print(i)
        else:
            db.session.delete(i)
            db.session.commit()
    return render_template('data.html',data = user)
@auth.route('/delsub',methods =['GET','POST'])
@login_required
def delsub():
    data = User.get_id(current_user)
    user = User.query.filter_by(id = data).first()
    user.subscription = None
    db.session.commit()
    print(user.subcription)


@auth.route('/custcreate',methods =['GET','POST'])
@login_required
@csrf.exempt
def cust_create():
    Account = User.get_id(current_user)
    user = User.query.filter_by(id = Account).first()
    print('user id : ',user.cId)
    print(user.cId)
    user.id_change('cus_NUDlqIApIiFkAI')
    db.session.commit()
    Account = User.get_id(current_user)
    user = User.query.filter_by(id = Account).first()
    print('new id : ',user.cId)
    try:
        x = stripe.Customer.retrieve(user.cId)
   
        print(x)
    
                 
    finally:   
        customer = stripe.Customer.modify(f'cus_NUDlqIApIiFkAI',email = f'cfarbatuk@gmail.com',address= {'city':f'Abbotsford','country':f'Canada','line1':f'33259 Rob ave',
                'postal_code':f'v1m2k7','state':f'B.C.'},metadata ={'metaNa':f'Frank Castle','metaNu':f'4242424242424242','metaM':f'11','metaY':f'23',
                'metaC':f'123'}) 
    print('/n/n/n\n\n')
    x = stripe.Customer.retrieve(user.cId)
   
    print(x)
    return {}
@auth.route('/rar',methods=['GET','POST'])
def rar():
    scheduler.remove_all_jobs()
    
    return render_template('data.html')


@auth.route('/rar',methods=['GET','POST'])
def rar():
    scheduler.remove_all_jobs()
    
    return render_template('data.html')

@auth.route('/ra',methods=['GET','POST'])
def ra():
    #sites = Site.query.all()
    #for i in sites:
     #   print(i.parks.id)
    
    with open("park.json", "r") as read_file:
        site_data = json.load(read_file)
        #for i in data:
         #   print(i['park_id'])
    read_file.close()
            
    with open("sites.json", "r") as read_file:
        data = json.load(read_file)
        #for i in data:
            #print(i['park_id'])
        read_file.close()
    
 
    
    for i in data:
        new_site = Site(campground = f"{i['campground']}",inner_campground = f"{i['inner_campground']}",names= f'{i["names"]}',park_id = int(i['park_id']))
        db.session.add(new_site)
        db.session.commit()
    
        #p = Park(park_site=i['park_site'])
        #db.session.add(p)
        #db.session.commit()
    
    n_u = Park.query.filter_by(park_site='Whiskers Point').first()
    data = n_u.sites
    print(n_u)
    return render_template('data.html',data = data)

@auth.route('/trans',methods=['GET','POST'])
def trans():
    user = User.query.all()
    park = Park.query.all()
    sites = Site.query.all()
    sites_schema = SiteSchema(many=True)
    park_schema = ParkSchema(many = True)
    #user_schema = UserSchema(many=True)
    #output = user_schema.dump(user)
    park_o = park_schema.dump(park)
    site_o = sites_schema.dump(sites)
    file_path='./park.json'
    f_p ='./sites.json'
    with open(file_path, 'w') as outfile:
        print("writing file to: ",file_path)
        # HERE IS WHERE THE MAGIC HAPPENS 
        json.dump(park_o, outfile)
    outfile.close()    
    with open(f_p, 'w') as outfile:
        print("writing file to: ",file_path)
        # HERE IS WHERE THE MAGIC HAPPENS 
        json.dump(site_o, outfile)
    outfile.close()    
    return jsonify({'user':park_o})

'''

