from memory_profiler import memory_usage,profile


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

if __name__ == '__main__'    :  

    main()

