from memory_profiler import memory_usage,profile
from datetime import datetime
from flask_apscheduler import APScheduler
scheduler = APScheduler()

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
  
    dict1 = []
    arrival_date=datetime(2023,8,26).date()
    arrival_date1=datetime(2023,3,26).date()
    arrival_date2=datetime(2023,7,23).date()
    scheduler.start()
    start_day, end_day = job_date(arrival_date)
    print('\n\n')

    
    def job_date(date_booking):

        if date_booking.month > ((datetime.now().month + 4)%12)  and date_booking.year == datetime.now().year:
                print('1')
                date_booked = f'{date_booking.year}-{date_booking.month-4}-{date_booking.day}'
                start_day = datetime(date_booking.year,date_booking.month-4,date_booking.day,6,53,0)
                print(start_day)
                end_day = f'{date_booked} 19:59:00'
            
        elif date_booking.month <= ((datetime.now().month + 4)%12) and date_booking >= datetime.now().date():
                print('2')
                if date_booking.month > datetime.now().month:
                    print(' 7 month ',date_booking)
                    start_day = datetime(datetime.now().year,datetime.now().month,datetime.now().day)
                    
                    end_day = datetime(date_booking.year,date_booking.month,date_booking.day,19,59,0)
                    print(start_day,end_day)
                    
                if date_booking.day > datetime.now().day:
                    date_booked = f'{datetime.now().year}-{datetime.now().month}-{datetime.now().day}'
                    start_day = datetime(datetime.now().year,datetime.now().month,datetime.now().day)
                    print(start_day)
                    end_day = datetime(date_booking.year,date_booking.month,date_booking.day,19,59,0)
                elif date_booking.day == datetime.now().day and datetime.now().time() < datetime(datetime.now().year,datetime.now().month,datetime.now().day,19,59,59).time():
                    date_booked = f'{datetime.now().year}-{datetime.now().month}-{datetime.now().day}'
                    start_day = datetime(datetime.now().year,datetime.now().month,datetime.now().day)
                    print(start_day)
                    end_day = datetime(datetime.now().year,datetime.now().month,datetime.now().day,19,59,0)
                
          
        elif date_booking.year > datetime.now().year:
            print('4')
            date_booked = f'{date_booking.year}-{date_booking.month-4}-{date_booking.day}'
            start_day =  datetime(date_booking.year,date_booking.month-4,date_booking.day,6,53,0)
            end_day = f'{date_booked} 19:59:00'
       
        print('return ',start_day,end_day)
        return start_day,end_day
    
    
    print(' Start Day : ',start_day, ' - End Day : ',end_day)
    def schedule_site():
        pass
    if start_day and end_day:
        print('1 ',start_day,end_day)
        scheduler.add_job(jobstore='default',func=schedule_site,trigger = 'interval',args=[], id=f'{1}',start_date=start_day,end_date=end_day,minutes =2,max_instances =1)
    start_day1, end_day1 = job_date(arrival_date1)
    print('\n\n')
    
    if start_day1 and end_day1:
        print('2 ',start_day1,end_day1)
        scheduler.add_job(jobstore='default',func=schedule_site,trigger = 'interval',args=[], id=f'{2}',start_date=start_day,end_date=end_day,minutes =2,max_instances =1)
    
    start_day2, end_day2 = job_date(arrival_date2)
    print('\n\n')

    print('3 ',start_day2,end_day2)
    print(start_day2 and end_day2)
    if start_day2 and end_day2:
        
        if start_day2 < datetime.now():
             print(start_day2 < datetime.now())
        scheduler.add_job(jobstore='default',func=schedule_site,trigger = 'interval',args=[], id=f'{3}',start_date=start_day,end_date=end_day,minutes =2,max_instances =1)
    for job in scheduler.get_jobs():
        print("name: %s, trigger: %s, next run: %s,job end date %s handler: %s" % (
          job.name, job.trigger, job.next_run_time,job.trigger.end_date, job.func),'\n')

        dict1.append(job.next_run_time)
     
    print(dict1)
    def rar():
        scheduler.remove_all_jobs()
        return 'removed'
    '''
    rar()
    dict2=[]
    arrival_date3=datetime(2023,10,23).date()
    start_day, end_day = job_date(arrival_date3)
    if start_day != None:
    
        scheduler.add_job(jobstore='default',func=schedule_site,trigger = 'interval',args=[], id=f'{6}',start_date=start_day,end_date=end_day,minutes =2,max_instances =1)
    arrival_date4=datetime(2023,3,23).date()
    start_day, end_day = job_date(arrival_date4)
    scheduler.add_job(jobstore='default',func=schedule_site,trigger = 'interval',args=[], id=f'{7}',start_date=start_day,end_date=end_day,minutes =2,max_instances =1)
    for job in scheduler.get_jobs():
        print("name: %s, trigger: %s, next run: %s,job end date %s handler: %s" % (
          job.name, job.trigger, job.next_run_time,job.trigger.end_date, job.func),'\n')

        dict2.append(job.next_run_time)
    rar()
    '''