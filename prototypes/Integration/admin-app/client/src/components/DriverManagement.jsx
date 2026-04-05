import React, { useState, useEffect } from 'react';
import { supabase } from '../supabaseClient';

const DriverManagement = () => {
  const [drivers, setDrivers] = useState([]);

  useEffect(() => {
    const fetchDrivers = async () => {
      const { data, error } = await supabase
        .from('drivers')
        .select(`
          *,
          buses ( bus_number )
        `);

      if (error) {
        console.error('Error fetching drivers:', error);
      } else {
        setDrivers(data);
      }
    };

    fetchDrivers();
  }, []);

  return (
    <div style={{padding: '20px'}}>
      <h1>👨‍✈️ Driver Roster</h1>
      <table style={{width: '100%', borderCollapse: 'collapse', marginTop: '20px'}}>
        <thead>
          <tr style={{borderBottom: '2px solid #444', textAlign: 'left'}}>
            <th style={{padding: '10px'}}>Full Name</th>
            <th style={{padding: '10px'}}>Phone</th>
            <th style={{padding: '10px'}}>License No</th>
            <th style={{padding: '10px'}}>Assigned Bus</th>
            <th style={{padding: '10px'}}>Status</th>
          </tr>
        </thead>
        <tbody>
          {drivers.map((driver) => (
            <tr key={driver.id} style={{borderBottom: '1px solid #333'}}>
              <td style={{padding: '10px'}}>{driver.full_name}</td>
              <td style={{padding: '10px'}}>{driver.phone}</td>
              <td style={{padding: '10px'}}>{driver.license_number}</td>
              <td style={{padding: '10px'}}>{driver.buses?.bus_number || 'None'}</td>
              <td style={{padding: '10px'}}>
                {driver.is_active ? '✅ Active' : '❌ Inactive'}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default DriverManagement;
