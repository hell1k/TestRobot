import random


def get_random_id():
    return random.randint(100, 10000)


def get_random_name(name=''):
    if name == 'new_name':
        list = ['Korjik', 'Bim', 'Drujok']
    else:
        list = ['Barbos', 'Bobik', 'Tuzik', 'Sharik']

    return random.choice(list)
