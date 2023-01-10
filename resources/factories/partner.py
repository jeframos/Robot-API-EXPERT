

def factory_new_partner():
    partner = {
        'name': 'Pizzas Papito',
        'email': 'contato@papito.com.br',
        'whatsapp': '11999999999',
        'business': 'Restaurante'
    }
    return partner

def factory_dup_name():
    partner = {
        'name': 'Adega do João',
        'email': 'contato@joao.com.br',
        'whatsapp': '61999999999',
        'business': 'Conveniência'
    }
    return partner

# Massa utilizada no método GET para deixar o teste independente
def factory_partner_list():
    p_list = [
        {
            'name': 'Mercearia da Mary Jane',
            'email': 'contato@mmj.com',
            'whatsapp': '11999991001',
            'business': 'Conveniência'
        },
        {
            'name': 'Mercadinho São Francisco',
            'email': 'contato@msf.com.br',
            'whatsapp': '11999991002',
            'business': 'Supermercado'
        },
        {
            'name': 'Bom de Prato',
            'email': 'contato@bomdeprato.com.br',
            'whatsapp': '11999991003',
            'business': 'Restaurante'
        }
    ]
    return p_list


def factory_enable_partner():
    partner = {
        'name': 'Papito Doceria',
        'email': 'doceria@yahoo.com',
        'whatsapp': '11999999999',
        'business': 'Conveniência'
    }
    return partner

def factory_disable_partner():
    partner = {
        'name': 'Mercado Noite',
        'email': 'contato@noite.com',
        'whatsapp': '11999999999',
        'business': 'Supermercado'
    }
    return partner

def factory_remove_partner():
    partner = {
        'name': 'Adega do Papito',
        'email': 'contato@adp.com.br',
        'whatsapp': '11999999999',
        'business': 'Conveniência'
    }
    return partner

def factory_404_partner():
    partner = {
        'name': 'Frangão',
        'email': 'contato@frangao.com',
        'whatsapp': '11999999999',
        'business': 'Restaurante'
    }
    return partner