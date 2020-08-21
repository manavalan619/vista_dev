
export const units = {
  mapFieldsToHeader:{
    id: 'ID',
    name: 'Unit name'
  },
  formFields: [{
    type: 'text',
    name:'name',
    id: 'name'
  }]
}

export const branches = {
  mapFieldsToHeader:{
    id: 'ID',
    name: 'Branch Name',
    address : 'Branch Address',
    telephone: 'Phone',
    email: 'Email',
    image: 'Image',
    branch_info: 'Branch Info'
  },
  formFields: [{
    type: 'text',
    name:'name',
    id: 'name'
  }, {
    type: 'text',
    name:'address',
    id: 'address'
  },{
    type: 'text',
    name:'telephone',
    id: 'telephone',
  }, {
    type: 'email',
    name:'email',
    id: 'email'
  }, {
    type: 'text',
    name:'image',
    id: 'image',
    placeholder: 'https://www.myimages/example.gif'
  }, {
    type: 'textarea',
    name:'branch_info',
    id: 'Branch Info'
  }]
}

export const partners = {
  mapFieldsToHeader:{
    id: 'ID',
    first_name: 'Forename',
    last_name: 'Surname',
    email: 'Email',
    mobile_number: 'Mobile Phone',
    password: 'Password'
  },
  formFields: [{
    type: 'text',
    name:'first_name',
    id: 'first_name'
  }, {
    type: 'text',
    name:'last_name',
    id: 'last_name'
  },{
    type: 'text',
    name:'email',
    id: 'email'
  },{
    type: 'text',
    name:'mobile_number',
    id: 'mobile_number'
  },{
    type: 'text',
    name:'password',
    id: 'password'
  }]
}

export const roles = {
  mapFieldsToHeader:{
    id: 'ID',
    name: 'Role'
  },
  formFields:[{
    type:'text',
    name: 'name',
    id: 'name'
  }]
}


export const staffMembers = {
  mapFieldsToHeader:{
    email: 'Email',
    employee_id: 'Employee ID',
    first_name: 'Forename',
    last_name: 'Surname',
    type: 'Access',
    branch: 'Branch',
    roles: 'Role'
  },
  fields:[
    {
      name: 'employee_id',
      type: 'text',
      label: 'Employee ID'
    },
    {
      name: 'first_name',
      type: 'text',
      label: 'First name'
    },
    {
      name: 'last_name',
      type: 'text',
      label: 'Surname'
    },
    {
      name: 'mobile_number',
      type: 'text',
      label: 'Mobile'
    },
    {
      name: 'type',
      type: 'select',
      label: 'Access level',
      options: [
        {
          text: 'Staff Member',
          value: 'StaffMember'
        },
        {
          text: 'Branch manager',
          value: 'BranchManager'
        },
        {
          text: 'Admin',
          value: 'Admin'
        }
      ]
    },
    {
      name: 'email',
      type: 'text',
      label: 'Email'

    },
    // {
    //   name: 'pin1',
    //   type: 'text',
    //   label: 'Pin',
    //   maxlength:'4'
    // },
    // {
    //   name: 'pin2',
    //   type: 'text',
    //   label: 'Verify Pin',
    //   maxlength:'4'
    // },
    // {
    //   name: 'status',
    //   type: 'select',
    //   label: 'Account Status',
    //   options: [
    //     {
    //       text: 'Active',
    //       value: 'active'
    //     },
    //     {
    //       text: 'Suspended',
    //       value: 'suspended'
    //     }
    //   ]
    // }
  ],
  extraFields:[
    {
      name: 'pin1',
      type: 'password',
      label: 'Pin',
      maxlength:'4'
    },
    {
      name: 'pin2',
      type: 'password',
      label: 'Verify Pin',
      maxlength:'4'
    }
  ]
}
