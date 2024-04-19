import mock from '../../mockAdapter';
// import type { ContactType } from '@/types/apps/ContactType';

import user1 from '@/assets/images/profile/user-1.jpg';
import user2 from '@/assets/images/profile/user-2.jpg';
import user3 from '@/assets/images/profile/user-3.jpg';
import user4 from '@/assets/images/profile/user-4.jpg';
import user5 from '@/assets/images/profile/user-5.jpg';
import user6 from '@/assets/images/profile/user-6.jpg';
import user7 from '@/assets/images/profile/user-7.jpg';
import user8 from '@/assets/images/profile/user-8.jpg';
import user9 from '@/assets/images/profile/user-9.jpg';
import user10 from '@/assets/images/profile/user-10.jpg';


// types
export type KeyedObject = {
    [key: string]: string | number | KeyedObject | any;
};

const contacts: KeyedObject[] = [
    {
        id: '1',
        avatar: user1,
        fecha_a: '10-1-24',
        usermail: '',
        phone: '10-2-25',
        estatus: 'Concluido',
        resultados: 'se espera bajar de peso',
        resultadosstatus: 'primary'
    },
    {
        id: '2',
        avatar: user2,
        fecha_a: '',
        usermail: '10-1-24',
        phone: '10-2-25',
        estatus: 'Actual',
        resultados: 'ganar masa muscular',
        resultadosstatus: 'secondary'
    },
    {
        id: '3',
        avatar: user3,
        fecha_a: '',
        usermail: '10-1-24',
        phone: '10-2-25',
        estatus: 'Suspendida',
        resultados: 'tener mas conejo',
        resultadosstatus: 'error'
    },
    {
        id: '4',
        avatar: user4,
        fecha_a: '',
        usermail: '10-1-24',
        phone: '10-2-25',
        estatus: 'Suspendida',
        resultados: 'incrementar resistencia',
        resultadosstatus: 'primary'
    },
    {
        id: '2',
        avatar: user5,
        fecha_a: '',
        usermail: '10-1-24',
        phone: '10-2-25',
        estatus: 'Actual',
        resultados: 'abdomen plano',
        resultadosstatus: 'success'
    },
   
];

// ==============================|| MOCK SERVICES ||============================== //

// mock.onGet('/api/products/list').reply(200, { products });
mock.onGet('/api/contacts').reply(() => {
    return [200, contacts];
});


export default contacts;
