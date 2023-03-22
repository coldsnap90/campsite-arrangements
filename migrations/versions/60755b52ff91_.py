"""empty message

Revision ID: 60755b52ff91
Revises: be5b49f17091
Create Date: 2023-03-21 18:02:38.198324

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '60755b52ff91'
down_revision = 'be5b49f17091'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('booking_data', schema=None) as batch_op:
        batch_op.add_column(sa.Column('occupant_postal_code', sa.String(length=50), nullable=True))

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('booking_data', schema=None) as batch_op:
        batch_op.drop_column('occupant_postal_code')

    # ### end Alembic commands ###