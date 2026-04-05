import React, { useState, useEffect } from 'react';
import { supabase } from '../supabaseClient';

const RouteManagement = () => {
  const [routes, setRoutes] = useState([]);

  useEffect(() => {
    const fetchRoutes = async () => {
      const { data, error } = await supabase
        .from('routes')
        .select('*');

      if (error) {
        console.error('Error fetching routes:', error);
      } else {
        setRoutes(data);
      }
    };

    fetchRoutes();
  }, []);

  return (
    <div style={{padding: '20px'}}>
      <h1>🛤️ Route Network</h1>
      <table style={{width: '100%', borderCollapse: 'collapse', marginTop: '20px'}}>
        <thead>
          <tr style={{borderBottom: '2px solid #444', textAlign: 'left'}}>
            <th style={{padding: '10px'}}>Number</th>
            <th style={{padding: '10px'}}>Route Name</th>
            <th style={{padding: '10px'}}>Distance (km)</th>
            <th style={{padding: '10px'}}>Est. Duration (min)</th>
            <th style={{padding: '10px'}}>Status</th>
          </tr>
        </thead>
        <tbody>
          {routes.map((route) => (
            <tr key={route.id} style={{borderBottom: '1px solid #333'}}>
              <td style={{padding: '10px', fontWeight: 'bold'}}>{route.route_number}</td>
              <td style={{padding: '10px'}}>{route.route_name}</td>
              <td style={{padding: '10px'}}>{route.total_distance_km}</td>
              <td style={{padding: '10px'}}>{route.estimated_duration_min}</td>
              <td style={{padding: '10px'}}>
                {route.is_active ? '✅ Operational' : '❌ Suspended'}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default RouteManagement;
