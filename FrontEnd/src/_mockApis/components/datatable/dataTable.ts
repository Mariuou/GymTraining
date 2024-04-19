
import type { Datatables,SelectedRowDatatable,filtrable } from '@/types/components/datatables/index';

import img1 from '@/assets/images/blog/blog-img1.jpg';
import img2 from '@/assets/images/blog/blog-img2.jpg';
import img3 from '@/assets/images/blog/blog-img3.jpg';
import img4 from '@/assets/images/blog/blog-img4.jpg';
import img5 from '@/assets/images/blog/blog-img5.jpg';

const BasicDatatables: Datatables[] = [
    {
        name: 'Renovar Bienestar',
        post: '3 semanas',
        project: '18-04-24',
        status: 'Activo',
        budget: '30%'
    },
    {
        name: 'Perdida de peso',
        post: '4 semanas',
        project: '10-10-23',
        status: 'Activo',
        budget: '70%'
    },
    {
        name: 'Programa de entrenamiento de resistencia muscular',
        post: '6 semanas',
        project: '04-002-23',
        status: 'Inactivo',
        budget: '50%'
    },
    {
        name: 'Programa de alimentación consciente',
        post: '5 semanas',
        project: '10-06-24',
        status: 'Activo',
        budget: '30%'
    },
    {
        name: 'Programa de caminatas al aire libr',
        post: '6 semanas',
        project: '5-02-23',
        status: 'Activo',
        budget: '22%'
    },
    {
        name: "Programa de ejercicios cardiovasculares",
        post: "8 semanas",
        project: "10-15-24",
        status: "Activo",
        budget: "60%"
    },
    {
        name: "Programa de nutrición balanceada",
        post: "12 semanas",
        project: "09-30-24",
        status: "Activo",
        budget: "80%"
    },
    {
        name: "Programa de entrenamiento funcional",
        post: "6 semanas",
        project: "11-05-24",
        status: "Activo",
        budget: "75%"
    },
    {
        name: "Programa de Pilates",
        post: "8 semanas",
        project: "11-12-24",
        status: "Activo",
        budget: "70%"
    },
    {
        name: "Programa de mindfulness para niños",
        post: "4 semanas",
        project: "11-18-24",
        status: "Activo",
        budget: "60%"
    },
    {
        name: "Programa de control de estrés",
        post: "12 semanas",
        project: "11-25-24",
        status: "Activo",
        budget: "80%"
    },
    {
        name: "Programa de carrera para principiantes",
        post: "10 semanas",
        project: "12-02-24",
        status: "Activo",
        budget: "65%"
    },
    {
        name: "Programa de cocina saludable",
        post: "6 semanas",
        project: "12-09-24",
        status: "Activo",
        budget: "75%"
    },
    {
        name: "Programa de Tai Chi",
        post: "8 semanas",
        project: "12-16-24",
        status: "Activo",
        budget: "70%"
    },
    {
        name: "Programa de entrenamiento de maratón",
        post: "16 semanas",
        project: "12-23-24",
        status: "Activo",
        budget: "85%"
    },
    {
        name: "Programa de terapia de grupo",
        post: "12 semanas",
        project: "12-30-24",
        status: "Activo",
        budget: "75%"
    },
    {
        name: "Programa de ejercicios para personas mayores",
        post: "10 semanas",
        project: "01-06-25",
        status: "Activo",
        budget: "70%"
    },
    {
        name: "Programa de hábitos de sueño saludables",
        post: "6 semanas",
        project: "01-13-25",
        status: "Activo",
        budget: "80%"
    },
    {
        name: 'Programa de entrenamiento de resistencia muscular avanzado',
        post: '8 semanas',
        project: '02-20-25',
        status: 'Activo',
        budget: '75%'
    },
    {
        name: 'Programa de yoga para principiantes',
        post: '6 semanas',
        project: '03-05-25',
        status: 'Activo',
        budget: '65%'
    },
    {
        name: 'Programa de meditación guiada',
        post: '4 semanas',
        project: '03-12-25',
        status: 'Activo',
        budget: '60%'
    },
    {
        name: 'Programa de ejercicios de alta intensidad (HIIT)',
        post: '10 semanas',
        project: '03-19-25',
        status: 'Activo',
        budget: '70%'
    },
    {
        name: 'Programa de entrenamiento de flexibilidad',
        post: '6 semanas',
        project: '03-26-25',
        status: 'Activo',
        budget: '55%'
    },
    {
        name: 'Programa de dieta cetogénica',
        post: '12 semanas',
        project: '04-02-25',
        status: 'Activo',
        budget: '80%'
    },
    {
        name: 'Programa de ejercicios de rehabilitación',
        post: '8 semanas',
        project: '04-09-25',
        status: 'Activo',
        budget: '70%'
    },
    {
        name: 'Programa de entrenamiento de boxeo',
        post: '10 semanas',
        project: '04-16-25',
        status: 'Activo',
        budget: '75%'
    },
    {
        name: 'Programa de alimentación vegana',
        post: '6 semanas',
        project: '04-23-25',
        status: 'Activo',
        budget: '65%'
    },
    {
        name: 'Programa de ejercicios acuáticos',
        post: '8 semanas',
        project: '04-30-25',
        status: 'Activo',
        budget: '70%'
    },
    {
        name: 'Programa de mindfulness para adolescentes',
        post: '4 semanas',
        project: '05-07-25',
        status: 'Activo',
        budget: '60%'
    },
    {
        name: 'Programa de ejercicios de estiramiento',
        post: '6 semanas',
        project: '05-14-25',
        status: 'Activo',
        budget: '55%'
    },
    {
        name: 'Programa de nutrición deportiva',
        post: '12 semanas',
        project: '05-21-25',
        status: 'Activo',
        budget: '75%'
    },
    {
        name: 'Programa de ejercicios de equilibrio y coordinación',
        post: '8 semanas',
        project: '05-28-25',
        status: 'Activo',
        budget: '65%'
    },
    {
        name: 'Programa de alimentación para aumento de masa muscular',
        post: '10 semanas',
        project: '06-04-25',
        status: 'Activo',
        budget: '80%'
    },
    {
        name: 'Programa de ejercicios de respiración',
        post: '6 semanas',
        project: '06-11-25',
        status: 'Activo',
        budget: '60%'
    },
    {
        name: 'Programa de entrenamiento para mejorar la postura',
        post: '8 semanas',
        project: '06-18-25',
        status: 'Activo',
        budget: '70%'
    },
    {
        name: 'Programa de alimentación sin gluten',
        post: '12 semanas',
        project: '06-25-25',
        status: 'Activo',
        budget: '75%'
    },
    {
        name: 'Programa de ejercicios para fortalecer la espalda',
        post: '10 semanas',
        project: '07-02-25',
        status: 'Activo',
        budget: '65%'
    },
    {
        name: 'Programa de yoga prenatal',
        post: '6 semanas',
        project: '07-09-25',
        status: 'Activo',
        budget: '60%'
    }
    
    
    
    
];

const SelectedRow: SelectedRowDatatable[] = [
    {
        name: 'Sunil Joshi',
        post: 'Web Designer',
        project: 'Elite Admin',
        status: 'Active',
        budget: '$3.9',
        selectable: false,
    },
    {
        name: 'Andrew McDownland',
        post: 'Project Manager',
        project: 'Real Homes WP Theme',
        status: 'Pending',
        budget: '$24.5k',
        selectable: true,
    },
    {
        name: 'Christopher Jamil',
        post: 'Project Manager',
        project: 'MedicalPro WP Theme',
        status: 'Completed',
        budget: '$12.8k',
        selectable: true,
    },
    {
        name: 'Nirav Joshi',
        post: 'Frontend Engineer',
        project: 'Hosting Press HTML',
        status: 'Active',
        budget: '$2.4k',
        selectable: false,
    },
    {
        name: 'Micheal Doe',
        post: 'Content Writer',
        project: 'Helping Hands WP Theme',
        status: 'Cancel',
        budget: '$9.3k',
        selectable: false,
    },
    {
        name: 'Jan Petrovic',
        post: 'Project Manager',
        project: 'Real Homes WP Theme',
        status: 'Pending',
        budget: '$24.5k',
        selectable: true,
    },
    {
        name: 'Daniel Kristeen',
        post: 'Project Manager',
        project: 'MedicalPro WP Theme',
        status: 'Completed',
        budget: '$12.8k',
        selectable: false,
    },
    {
        name: 'Julian Josephs',
        post: 'Web Designer',
        project: 'Elite Admin',
        status: 'Active',
        budget: '$3.9',
        selectable: true
    },
    {
        name: 'Leanne Graham',
        post: 'Project Manager',
        project: 'Real Homes WP Theme',
        status: 'Pending',
        budget: '$24.5k',
        selectable: false,
    },
    {
        name: 'Glenna Reichert',
        post: 'Web DEveloper',
        project: 'Monster Admin',
        status: 'Pending',
        budget: '$30.5k',
        selectable: true,
    },
    
];

const UppercaseFilter: Datatables[] = [
    {
        name: 'hop',
        post: 'Web Designer',
        project: 'Elite Admin',
        status: 'Active',
        budget: '$3.9',
    
    },
    {
        name: 'Andrew McDownland',
        post: 'Project Manager',
        project: 'Real Homes WP Theme',
        status: 'Pending',
        budget: '$24.5k',
    },
    {
        name: 'Christopher Jamil',
        post: 'Project Manager',
        project: 'MedicalPro WP Theme',
        status: 'Completed',
        budget: '$12.8k',
    },
    {
        name: 'Nirav Joshi',
        post: 'Frontend Engineer',
        project: 'Hosting Press HTML',
        status: 'Active',
        budget: '$2.4k',
    },
    {
        name: 'MICHEL DOE',
        post: 'Content Writer',
        project: 'Helping Hands WP Theme',
        status: 'Cancel',
        budget: '$9.3k',
    },
    {
        name: 'JAN PETROVICK',
        post: 'Project Manager',
        project: 'Real Homes WP Theme',
        status: 'Pending',
        budget: '$24.5k',
    },
    {
        name: 'Daniel Kristeen',
        post: 'Project Manager',
        project: 'MedicalPro WP Theme',
        status: 'Completed',
        budget: '$12.8k',
    },
    {
        name: 'Julian Josephs',
        post: 'Web Designer',
        project: 'Elite Admin',
        status: 'Active',
        budget: '$3.9',
    },
    {
        name: 'Leanne Graham',
        post: 'Project Manager',
        project: 'Real Homes WP Theme',
        status: 'Pending',
        budget: '$24.5k',
    },
    {
        name: 'Glenna Reichert',
        post: 'Web DEveloper',
        project: 'Monster Admin',
        status: 'Pending',
        budget: '$30.5k',
    },
    
    
];

const GroupTable: Datatables[] = [
    {
        name: 'Sunil Joshi',
        post: 'Web Designer',
        project: 'Elite Admin',
        status: 'Active',
        budget: '$3.9',
    
    },
    {
        name: 'Andrew McDownland',
        post: 'Project Manager',
        project: 'Real Homes WP Theme',
        status: 'Pending',
        budget: '$24.5k',
    },
    {
        name: 'Christopher Jamil',
        post: 'Project Manager',
        project: 'MedicalPro WP Theme',
        status: 'Completed',
        budget: '$12.8k',
    },
    {
        name: 'Nirav Joshi',
        post: 'Frontend Engineer',
        project: 'Hosting Press HTML',
        status: 'Active',
        budget: '$2.4k',
    },
    {
        name: 'MICHEL DOE',
        post: 'Content Writer',
        project: 'Helping Hands WP Theme',
        status: 'Cancel',
        budget: '$9.3k',
    },
    {
        name: 'JAN PETROVICK',
        post: 'Project Manager',
        project: 'Real Homes WP Theme',
        status: 'Pending',
        budget: '$24.5k',
    },
    {
        name: 'Daniel Kristeen',
        post: 'Project Manager',
        project: 'MedicalPro WP Theme',
        status: 'Completed',
        budget: '$12.8k',
    },
    {
        name: 'Julian Josephs',
        post: 'Web Designer',
        project: 'Elite Admin',
        status: 'Active',
        budget: '$3.9',
    },
    {
        name: 'Leanne Graham',
        post: 'Project Manager',
        project: 'Real Homes WP Theme',
        status: 'Pending',
        budget: '$24.5k',
    },
    {
        name: 'Glenna Reichert',
        post: 'Web DEveloper',
        project: 'Monster Admin',
        status: 'Pending',
        budget: '$30.5k',
    },
    
];

const Filtrable: filtrable[] = [
    {
        name: 'Nebula GTX 3080',
        image: img1,
        price: 699.99,
        rating: 5,
        stock: true,
    },
    {
        name: 'Galaxy RTX 3080',
        image: img2,
        price: 799.99,
        rating: 4,
        stock: false,
    },
    {
        name: 'Orion RX 6800 XT',
        image: img3,
        price: 649.99,
        rating: 3,
        stock: true,
    },
    {
        name: 'Vortex RTX 3090',
        image: img4,
        price: 1499.99,
        rating: 4,
        stock: true,
    },
    {
        name: 'Cosmos GTX 1660 Super',
        image: img5,
        price: 299.99,
        rating: 4,
        stock: false,
    },
    
];

export {BasicDatatables,SelectedRow,UppercaseFilter,GroupTable,Filtrable};
