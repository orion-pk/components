# @orion-pk/components

> Shared Component Library & Design System for Orion Applications (Academy, Medicare, POS).

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![GitHub release](https://img.shields.io/github/v/release/orion-pk/components?color=02658b)](https://github.com/orion-pk/components/releases)

---

## 📦 Installation

### Web (React)
```bash
# Option 1: Install directly from GitHub
npm install github:orion-pk/components

# Option 2: Install via npm
npm install @orion-pk/components
```

### Mobile & Multiplatform (Flutter)
Add to your Flutter app's `pubspec.yaml`:
```yaml
dependencies:
  orion_components:
    git:
      url: https://github.com/orion-pk/components.git
      path: flutter
      ref: main
```

Then import in Dart:
```dart
import 'package:orion_components/orion_components.dart';
```

---

## 🚀 Quick Setup

Include the CSS styles in your main entry file (e.g., `main.jsx` or `App.jsx`):

```javascript
import '@orion-pk/components/dist/style.css';
```

---

## 🧩 Component Catalog

### 1. SearchBar & FilterButton
Debounced search input with clear button, optional filter toggle, and custom pill buttons matching the User & Role Management screen.

```jsx
import { SearchBar, FilterButton } from '@orion-pk/components';

function UserManagement() {
  const [query, setQuery] = useState('');
  const [filter, setFilter] = useState('all');

  return (
    <div>
      <SearchBar 
        value={query}
        onChange={setQuery}
        placeholder="Search by name, role, email or CNIC..."
        showFilterToggle
      />
      <div style={{ display: 'flex', gap: 8, marginTop: 8 }}>
        <FilterButton label="All Records" count={42} active={filter === 'all'} onClick={() => setFilter('all')} />
        <FilterButton label="Teachers" count={12} active={filter === 'teachers'} onClick={() => setFilter('teachers')} />
        <FilterButton label="Students" count={30} active={filter === 'students'} onClick={() => setFilter('students')} />
      </div>
    </div>
  );
}
```

---

### 2. Action Buttons
Standardized action buttons with variants (`primary`, `secondary`, `danger`, `outline`, `ghost`), loading spinners, and icon slots.

```jsx
import { Button } from '@orion-pk/components';
import { UserPlus, Download } from 'lucide-react';

<Button variant="primary" iconLeft={<UserPlus size={16} />}>Add User</Button>
<Button variant="secondary" iconLeft={<Download size={16} />}>Export</Button>
<Button variant="danger">Delete Account</Button>
<Button variant="primary" isLoading>Saving...</Button>
```

---

### 3. DataGrid & Pagination
Tabular data grid with sortable columns, custom cell renderers, and the exact pagination control from Academia.

```jsx
import { DataGrid, Pagination, StatusPill } from '@orion-pk/components';

const columns = [
  { header: 'ID', field: 'id', width: '60px' },
  { header: 'Full Name', field: 'name' },
  { header: 'Role', field: 'role' },
  { 
    header: 'Status', 
    field: 'status', 
    render: (val) => <StatusPill status={val} /> 
  }
];

const data = [
  { id: 1, name: 'Dr. Sarah Connor', role: 'Faculty Teacher', status: 'completed' },
  { id: 2, name: 'Ali Ahmed', role: 'Student', status: 'registered' },
  { id: 3, name: 'Zainab Fatima', role: 'Student', status: 'pending' }
];

function UsersTable() {
  const [page, setPage] = useState(1);
  const [pageSize, setPageSize] = useState(10);

  return (
    <div>
      <DataGrid columns={columns} data={data} keyField="id" />
      <Pagination 
        currentPage={page} 
        pageSize={pageSize} 
        totalItems={100} 
        onPageChange={setPage} 
        onPageSizeChange={setPageSize} 
      />
    </div>
  );
}
```

---

### 4. Dialogues & Modals (Add/Edit User, User Details)
Modal containers with role chips, CNIC formatters (`1234-5678910-2`), phone number filters, and password toggles.

```jsx
import { UserDialogModal, UserDetailsCard, ConfirmModal } from '@orion-pk/components';

function AdminWorkspace() {
  const [isAddOpen, setIsAddOpen] = useState(false);
  const [isConfirmOpen, setIsConfirmOpen] = useState(false);

  return (
    <>
      <UserDialogModal 
        isOpen={isAddOpen}
        mode="add"
        onClose={() => setIsAddOpen(false)}
        onSubmit={(userData) => console.log('Created User:', userData)}
      />

      <UserDetailsCard 
        user={{ name: 'Professor David Miller', role: 'Head of CS', email: 'david@orion.edu' }}
        onEdit={() => console.log('Edit')}
        onDelete={() => setIsConfirmOpen(true)}
      />

      <ConfirmModal 
        isOpen={isConfirmOpen}
        title="Delete User"
        message="Are you sure you want to permanently delete this user?"
        onConfirm={() => setIsConfirmOpen(false)}
        onCancel={() => setIsConfirmOpen(false)}
      />
    </>
  );
}
```

---

### 5. Navigation, Versioning & Updates
Top navigation header, profile dropdown avatar, version badge, and in-app update dialogues.

```jsx
import { Navbar, VersionBadge, ProfileDropdown, UpdateProgressBar } from '@orion-pk/components';

<Navbar 
  brandName="Orion Academy"
  user={{ name: 'Super Admin', email: 'admin@orion.edu', role: 'Super Admin' }}
  currentVersion="v2.4.0"
  hasUpdate={true}
  onLogout={() => console.log('Logout')}
/>

<UpdateProgressBar progress={68} statusText="Downloading Release v2.4.1" />
```

---

### 6. Badges & Pills
```jsx
import { StatusPill, SeverityPill, GlobalPermissionsBadge } from '@orion-pk/components';

<StatusPill status="completed" />
<StatusPill status="registered" />
<StatusPill status="pending" />
<StatusPill status="in_consultation" />
<StatusPill status="unregistered" />

<SeverityPill severity="minor" />
<SeverityPill severity="moderate" />
<SeverityPill severity="major" />
<SeverityPill severity="critical" />

<GlobalPermissionsBadge role="Super Admin" permissionsCount={54} />
```

---

### 7. Form Controls & Authentication
```jsx
import { LoginForm, PhoneInput, FormSelect } from '@orion-pk/components';

<LoginForm onSubmit={({ username, password }) => handleLogin(username, password)} />
<PhoneInput label="Contact Number" placeholder="123 045 223 48" value={phone} onChange={setPhone} />
<FormSelect label="Role" options={['Admin', 'Teacher', 'Student', 'Parent']} value={role} onChange={setRole} />
```

---

## 🛠️ Development & Building

```bash
# Install dependencies
npm install

# Run dev preview
npm run dev

# Build ESM & CJS distribution bundles
npm run build
```

---

## 📄 License
MIT © Orion PK Team
