import React, { useState, useEffect } from 'react';
import { supabase } from '../supabaseClient';

const BusManagement = () => {
  const [buses, setBuses] = useState([]);

  useEffect(() => {
    const fetchBuses = async () => {
      const { data, error } = await supabase
        .from('buses')
        .select(`
          *,
          drivers ( full_name ),
          routes ( route_name, route_number )
        `);

      if (error) {
        console.error('Error fetching buses:', error);
      } else {
        setBuses(data);
      }
    };

    fetchBuses();
  }, []);

  return (
    <div style={{padding: '20px'}}>
      <h1>🚌 Fleet Management</h1>
      <table style={{width: '100%', borderCollapse: 'collapse', marginTop: '20px'}}>
        <thead>
          <tr style={{borderBottom: '2px solid #444', textAlign: 'left'}}>
            <th style={{padding: '10px'}}>Bus Number</th>
            <th style={{padding: '10px'}}>Assigned Driver</th>
            <th style={{padding: '10px'}}>Route</th>
            <th style={{padding: '10px'}}>Capacity</th>
            <th style={{padding: '10px'}}>Status</th>
          </tr>
        </thead>
        <tbody>
          {buses.map((bus) => (
            <tr key={bus.id} style={{borderBottom: '1px solid #333'}}>
              <td style={{padding: '10px', fontWeight: 'bold'}}>{bus.bus_number}</td>
              <td style={{padding: '10px'}}>{bus.drivers?.full_name || 'Unassigned'}</td>
              <td style={{padding: '10px'}}>
                {bus.routes ? `${bus.routes.route_number}: ${bus.routes.route_name}` : 'No Route'}
              </td>
              <td style={{padding: '10px'}}>{bus.capacity}</td>
              <td style={{padding: '10px'}}>
                <span style={{
                  padding: '4px 8px', 
                  borderRadius: '4px', 
                  fontSize: '12px',
                  background: bus.status === 'active' ? '#2d5a27' : '#5a2d27'
                }}>
                  {bus.status.toUpperCase()}
                </span>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default BusManagement;
